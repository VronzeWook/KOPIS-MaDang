//
//  DetailReviewView.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//
import SwiftUI

struct DetailReviewView: View {
    @State private var reviews: [Review] = []
    @Binding var perform: Performance
    @EnvironmentObject var userManager: UserManager
    @State private var selection: Country = .ALL
    

    var body: some View {
        VStack {
            HStack {
                Text("Reviews")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Spacer()
                
                NavigationLink {
                    ReviewEditorView(perform: $perform)
                } label: {
                    HStack {
                        Image(systemName: "text.bubble.fill")
                            .foregroundStyle(.nineYellow)
                        Text("Write")
                            .font(.system(size: 14))
                            .foregroundStyle(.nineYellow)
                    }
                }
            }
            
            SegmentedCountryView(selection: $selection)
            
            ForEach($reviews) { $review in
                if review.writerCountry == selection || selection == .ALL {
                    ReviewPostView(review: $review)
                }
            }
            
            Rectangle()
                .foregroundStyle(.gray)
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 5)
                .padding(.top, 40)
        }
        .onAppear {
            FirestoreManager.shared.fetchReviewsByPerformance(performanceId: perform.id) { result in
                switch result {
                case .success(let reviews):
                    if reviews.isEmpty {
                        print("No reviews available.")
                    } else {
                        self.reviews = reviews
                        print("Fetched reviews successfully.")
                        print("user : \(userManager.user?.name ?? "nil")")
                        for review in reviews {
                            print(review.id!)
                            print(review.performanceId)
                            print(review.content)
                            print(review.writerId)
                        }
                    }
                case .failure(let error):
                    print("Failed to fetch reviews: \(error.localizedDescription)")
                }
            }
            
            
        }
        .background(.black)
    }
    
    private struct ReviewPostView: View {
        @State private var isLike = false
        @Binding var review: Review
        @EnvironmentObject var userManager: UserManager

        private var formattedDate: String {
              let formatter = DateFormatter()
              formatter.dateFormat = "yyyy-MM-dd"
              return formatter.string(from: review.createdDate)
          }
        
        var body: some View {
            if let user = userManager.user {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundStyle(.white)
                        
                        Text("\(user.name) \(user.country.rawValue)")
                            .foregroundStyle(.white)
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding(.bottom, 8)
                    
                    HStack {
                        StarRatingView(rating: review.starRating)
                        Spacer()
                        Text(formattedDate)
                            .font(.system(size: 12))
                            .foregroundStyle(.gray)
                    }
                    .padding(.bottom, 8)
                    
                    ExpandableTextView(text: review.content)
                        .padding(.bottom, 16)
                    
                    HStack {
                        Button(action: {
                            if isLike {
                                review.likeCount -= 1
                                removeLikeReviewId(review.id)
                            } else {
                                review.likeCount += 1
                                if let id = review.id {
                                    userManager.user?.likeReviewIdList.append(id)
                                }
                            }
                            isLike.toggle()
                            FirestoreManager.shared.upsertReview(performId: review.performanceId, writerId: review.writerId, review: review) { result in
                                switch result {
                                case .success():
                                    print("LikeCount update success")
                                case .failure(_):
                                    print("LikeCount update failure")
                                }
                            }
                            
                            guard let user = userManager.user else { return }
                            FirestoreManager.shared.updateUser(user) { result in
                                switch result {
                                case .success():
                                    print("User Like Review update success")
                                case .failure(_):
                                    print("User Like Review update failure")
                                }
                            }
                        }, label: {
                            HStack(spacing: 2) {
                                Image(systemName: isLike ? "hand.thumbsup.fill" : "hand.thumbsup")
                                    .foregroundStyle(.nineYellow)
                                Text("\(review.likeCount)")
                                    .foregroundStyle(.nineYellow)
                                    .font(.system(size: 14))
                            }
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(.gray)
                        })
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.nineDarkGray)
                )
                .onAppear {
                    if let user = userManager.user {
                        for reviewId in user.likeReviewIdList {
                            if reviewId == self.review.id {
                                isLike = true
                            }
                        }
                    }
                }
            }
        }
        
        private func removeLikeReviewId(_ id: String?) {
            guard let id = id else { return }
            guard let index = userManager.user?.likeReviewIdList.firstIndex(of: id) else { return }
            userManager.user?.likeReviewIdList.remove(at: index)
        }
    }
    
    private struct StarRatingView: View {
        var rating: Double
        
        var body: some View {
            HStack(spacing: 1) {
                ForEach(0..<5) { index in
                    self.starType(for: index)
                        .foregroundColor(.nineYellow)
                }
                
                Text(String(format: "%.1f", rating))
                    .font(.system(size: 14))
                    .foregroundStyle(.nineYellow)
            }
        }
        
        func starType(for index: Int) -> Image {
            let starValue = Double(index) + 1
            
            if rating >= starValue {
                return Image(systemName: "star.fill")
            } else if rating >= starValue - 0.5 {
                return Image(systemName: "star.leadinghalf.filled")
            } else {
                return Image(systemName: "star")
            }
        }
    }
    
    private struct ExpandableTextView: View {
        let text: String
        @State private var isExpanded: Bool = false
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(text)
                    .font(.body)
                    .lineLimit(isExpanded ? nil : 2)
                    .foregroundColor(.white)
                    .onTapGesture {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }
            }
        }
    }

    private struct SegmentedCountryView: View {
        @Binding var selection: Country
        
        var body: some View {
            ScrollView(.horizontal) {
                HStack {
                    Button(action: {
                        selection = .ALL
                    }, label: {
                        Text("All")
                            .font(.system(size: 16))
                            .foregroundStyle(selection == .ALL ? .nineBlack : .white)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 8)
                            .background(selection == .ALL ? .nineYellow : .nineDarkGray)
                            .cornerRadius(55)
                    })
                    
                    Button(action: {
                        selection = .USA
                    }, label: {
                        Text("🇺🇸 USA")
                            .font(.system(size: 16))
                            .foregroundStyle(selection == .USA ? .nineBlack : .white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(selection == .USA ? .nineYellow : .nineDarkGray)
                            .cornerRadius(55)
                    })
                    
                    Button(action: {
                        selection = .CHN
                    }, label: {
                        Text("🇨🇳 CHN")
                            .font(.system(size: 16))
                            .foregroundStyle(selection == .CHN ? .nineBlack : .white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(selection == .CHN ? .nineYellow : .nineDarkGray)
                            .cornerRadius(55)
                    })
                    
                    Button(action: {
                        selection = .JPN
                    }, label: {
                        Text("🇯🇵 JPN")
                            .font(.system(size: 16))
                            .foregroundStyle(selection == .JPN ? .nineBlack : .white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(selection == .JPN ? .nineYellow : .nineDarkGray)
                            .cornerRadius(55)
                    })
                }
            }
            .padding(.vertical, 16)
        }
    }
    
    
}

//#Preview {
//    DetailReviewView(reviews: <#T##Binding<[Review]>#>, perform: <#T##Binding<Performance>#>)
//}
