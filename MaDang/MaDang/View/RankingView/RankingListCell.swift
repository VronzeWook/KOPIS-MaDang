//
//  RankingListCell.swift
//  MaDang
//
//  Created by 추서연 on 8/18/24.
//

import SwiftUI

struct RankingListCell: View {
    let rank: Int
    @Binding var perform: Performance
    let selection: Int
    @State private var averageRating: Double = 0.0
    
    var likeCount: Int {
        switch selection {
        case 0:
            return perform.likeCount
        case 1:
            return perform.likeCountUSA
        case 2:
            return perform.likeCountCHN
        case 3:
            return perform.likeCountJPN
        default:
            return perform.likeCount
        }
    }
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let imageWidth = screenWidth * 1 / 3.1
        let aspectRatio: CGFloat = 173 / 123
        
        HStack(alignment:.top){
            VStack(alignment:.leading){
                HStack {
                    Circle()
                        .frame(width: 33, height: 33)
                        .foregroundColor(.nineYellow.opacity(0.2))
                        .overlay(
                            Text("\(rank)")
                                .font(.system(size: 18))
                                .fontWeight(.semibold)
                                .foregroundStyle(.nineYellow)
                        )
                        .padding(.horizontal, 15)
                    
                    Spacer()
                    
                    Image(systemName: "heart.fill")
                        .font(.system(size: 14))
                        .foregroundStyle(.nineYellow)
                    Text("\(likeCount)")
                        .font(.system(size: 12))
                        .fontWeight(.semibold)
                        .foregroundStyle(.nineYellow)
                        .padding(.trailing, 16)
                }
                .padding(.top, 15)
                
                StarRatingView(rating: averageRating)  // Updated to use averageRating
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                
                Text(perform.title)
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.top, 1)
                
                Text(perform.genre.rawValue)
                    .font(.system(size: 10))
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(Color.white, lineWidth: 1)
                            .background(Color.clear)
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 0)
                    .padding(.bottom, 16)
                
            }
            
            AsyncImage(url: URL(string: perform.posterUrlList[0])) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
            } placeholder: {
                Color.gray
            }
        }
        .background(.nineDarkGray)
        .cornerRadius(10)
        .onAppear {
            loadAverageRating()
        }
        .onChange(of: perform) { _ in
            loadAverageRating()
        }
    }
    
    private func loadAverageRating() {
        FirestoreManager.shared.fetchReviewsByPerformance(performanceId: perform.id) { result in
            switch result {
            case .success(let reviews):
                let totalRating = reviews.reduce(0) { $0 + $1.starRating }
                self.averageRating = reviews.isEmpty ? 0 : totalRating / Double(reviews.count)
            case .failure(let error):
                print("Failed to fetch reviews: \(error.localizedDescription)")
            }
        }
    }
}

extension RankingListCell {
    private struct StarRatingView: View {
        var rating: Double
        
        var body: some View {
            HStack (spacing: 0) {
                ForEach(0..<5) { index in
                    self.starType(for: index)
                        .foregroundColor(.nineYellow)
                        .font(.system(size: 14))
                }
                
                Text(String(format: "%.2f", rating))
                    .padding(.top, 3)
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundStyle(.nineYellow)
                    .padding(.leading, 10)
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
}
