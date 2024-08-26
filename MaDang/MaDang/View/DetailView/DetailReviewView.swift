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
    @State private var showModal = false
    @State private var selectedReview: Review?
    @Binding var isReportModalPresented: Bool
    
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
                    ReviewPostView(review: $review, showModal: $showModal, selectedReview: $selectedReview)
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
        .sheet(isPresented: $showModal) {
            if let review = selectedReview {
                ReviewActionSheet(isPresented: $showModal, review: review, isReportModalPresented: $isReportModalPresented)
                    .background(.nineDarkGray)
                    .presentationDetents([.fraction(0.2)]) // 모달의 높이를 화면의 20%로 설정
                    .presentationDragIndicator(.visible)
            }
        }
    }
    
    private struct ReviewPostView: View {
        @State private var isLike = false
        @Binding var review: Review
        @EnvironmentObject var userManager: UserManager
        @Binding var showModal: Bool
        @Binding var selectedReview: Review?

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
                        
                        Text("\(review.writerName) \(review.writerCountry.flag)")
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
                            guard let user = userManager.user else { return }

                            // Step 1: 업데이트할 유저 정보 복사
                            var updatedUser = user

                            // Step 2: Like/Unlike 처리 및 review의 likeCount 갱신
                            if isLike {
                                if review.likeCount > 0 {
                                    review.likeCount -= 1
                                }

                                if let index = updatedUser.likeReviewIdList.firstIndex(of: review.id!) {
                                    updatedUser.likeReviewIdList.remove(at: index)
                                }
                            } else {
                                review.likeCount += 1
                                  // empathyCount 증가
                                if let id = review.id {
                                    updatedUser.likeReviewIdList.append(id)
                                }
                            }

                            isLike.toggle()

                            // Step 3: Firestore에 review 업데이트
                            FirestoreManager.shared.upsertReview(performId: review.performanceId, writerId: review.writerId, review: review) { reviewResult in
                                switch reviewResult {
                                case .success():
                                    updateUserEmpathyCount(for: review.writerId, increment: isLike)
                                    // 토글됬으니 반대로
                                    // Step 4: Firestore에 유저 정보 업데이트
                                    FirestoreManager.shared.updateUser(updatedUser) { userResult in
                                        switch userResult {
                                        case .success():
                                            // Firestore에 업데이트가 완료된 후, UI를 메인 쓰레드에서 갱신
                                            DispatchQueue.main.async {
                                                userManager.user = updatedUser  // 업데이트된 유저 정보로 교체
                                                print("User Like Review update success")
                                            }
                                        case .failure(let error):
                                            print("User Like Review update failure: \(error.localizedDescription)")
                                        }
                                    }
                                    print("LikeCount update success")
                                case .failure(let error):
                                    print("LikeCount update failure: \(error.localizedDescription)")
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
                            selectedReview = review
                            showModal = true
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
        
        private func updateUserEmpathyCount(for writerId: String, increment: Bool) {
            FirestoreManager.shared.fetchUserById(userId: writerId) { result in
                switch result {
                case .success(var user):
                    user.empathyCount += increment ? 1 : -1

                    FirestoreManager.shared.updateUser(user) { updateResult in
                        switch updateResult {
                        case .success():
                            DispatchQueue.main.async {
                                userManager.user = user
                                print("User Like Review update success")
                            }
                            print("Writer's empathyCount updated successfully in Firestore")
                        case .failure(let error):
                            print("Failed to update writer's empathyCount in Firestore: \(error.localizedDescription)")
                        }
                    }
                case .failure(let error):
                    print("Failed to fetch writer for updating empathyCount: \(error.localizedDescription)")
                }
            }
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

struct ReviewActionSheet: View {
    @Binding var isPresented: Bool
    var review: Review
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var reportManager: ReportManager
    @Binding var isReportModalPresented: Bool
    
    var body: some View {
        
        ZStack{
            Color.nineDarkGray
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                if userManager.user?.id == review.writerId {
                    
                    Button(action: {
                        FirestoreManager.shared.deleteReview(reviewId: review.id!) { result in
                            switch result {
                            case .success():
                                print("Review deleted successfully.")
                                isPresented = false
                            case .failure(let error):
                                print("Failed to delete review: \(error.localizedDescription)")
                            }
                        }
                    }, label: {
                        Text("Delete Review")
                            .foregroundStyle(.nineYellow)
                    })
                    
                } else {
                    Button("Report Review") {
                        withAnimation {
                            isReportModalPresented.toggle()
                            isPresented = false
                        }
                        reportManager.selectedReview = review
                    }
                    .foregroundColor(.nineYellow)
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray)
                
                Button("Cancel") {
                    isPresented = false
                }
                .foregroundColor(.red)
            }
            .padding()
            .background(Color.nineDarkGray) // 배경을 .nineDarkGray로 설정
            .cornerRadius(16)
            .ignoresSafeArea(.all, edges: .bottom) // 하단 여백을 채우기 위해 설정
            .frame(maxWidth: .infinity)
            .padding()
        }
    }
}

//#Preview {
//    DetailReviewView(reviews: <#T##Binding<[Review]>#>, perform: <#T##Binding<Performance>#>)
//}




//import SwiftUI
//
//struct DetailReviewView: View {
//    @State private var reviews: [Review] = []
//    @Binding var perform: Performance
//    @EnvironmentObject var userManager: UserManager
//    @State private var selection: Country = .ALL
//    
//
//    var body: some View {
//        VStack {
//            HStack {
//                Text("Reviews")
//                    .font(.system(size: 22))
//                    .fontWeight(.bold)
//                    .foregroundStyle(.white)
//                
//                Spacer()
//                
//                NavigationLink {
//                    ReviewEditorView(perform: $perform)
//                } label: {
//                    HStack {
//                        Image(systemName: "text.bubble.fill")
//                            .foregroundStyle(.nineYellow)
//                        Text("Write")
//                            .font(.system(size: 14))
//                            .foregroundStyle(.nineYellow)
//                    }
//                }
//            }
//            
//            SegmentedCountryView(selection: $selection)
//            
//            ForEach($reviews) { $review in
//                if review.writerCountry == selection || selection == .ALL {
//                    ReviewPostView(review: $review)
//                }
//            }
//            
//            Rectangle()
//                .foregroundStyle(.gray)
//                .frame(height: 1)
//                .frame(maxWidth: .infinity)
//                .padding(.horizontal, 5)
//                .padding(.top, 40)
//        }
//        .onAppear {
//            FirestoreManager.shared.fetchReviewsByPerformance(performanceId: perform.id) { result in
//                switch result {
//                case .success(let reviews):
//                    if reviews.isEmpty {
//                        print("No reviews available.")
//                    } else {
//                        self.reviews = reviews
//                        print("Fetched reviews successfully.")
//                        print("user : \(userManager.user?.name ?? "nil")")
//                        for review in reviews {
//                            print(review.id!)
//                            print(review.performanceId)
//                            print(review.content)
//                            print(review.writerId)
//                        }
//                    }
//                case .failure(let error):
//                    print("Failed to fetch reviews: \(error.localizedDescription)")
//                }
//            }
//            
//            
//        }
//        .background(.black)
//    }
//    
//    private struct ReviewPostView: View {
//        @State private var isLike = false
//        @Binding var review: Review
//        @EnvironmentObject var userManager: UserManager
//
//        private var formattedDate: String {
//              let formatter = DateFormatter()
//              formatter.dateFormat = "yyyy-MM-dd"
//              return formatter.string(from: review.createdDate)
//          }
//
//        var body: some View {
//            if let user = userManager.user {
//                VStack(alignment: .leading) {
//                    HStack {
//                        Image(systemName: "person.crop.circle.fill")
//                            .foregroundStyle(.white)
//                        
//                        Text("\(user.name) \(user.country.flag)")
//                            .foregroundStyle(.white)
//                            .font(.system(size: 14))
//                            .fontWeight(.bold)
//                        
//                        Spacer()
//                    }
//                    .padding(.bottom, 8)
//                    
//                    HStack {
//                        StarRatingView(rating: review.starRating)
//                        Spacer()
//                        Text(formattedDate)
//                            .font(.system(size: 12))
//                            .foregroundStyle(.gray)
//                    }
//                    .padding(.bottom, 8)
//                    
//                    ExpandableTextView(text: review.content)
//                        .padding(.bottom, 16)
//                    
//                    HStack {
//                        
//                        Button(action: {
//                            guard let user = userManager.user else { return }
//
//                            // Step 1: 업데이트할 유저 정보 복사
//                            var updatedUser = user
//
//                            // Step 2: Like/Unlike 처리 및 review의 likeCount 갱신
//                            if isLike {
//                                if review.likeCount > 0 {
//                                    review.likeCount -= 1
//                                }
//
//                                if let index = updatedUser.likeReviewIdList.firstIndex(of: review.id!) {
//                                    updatedUser.likeReviewIdList.remove(at: index)
//                                }
//                            } else {
//                                review.likeCount += 1
//                                  // empathyCount 증가
//                                if let id = review.id {
//                                    updatedUser.likeReviewIdList.append(id)
//                                }
//                            }
//
//                            isLike.toggle()
//
//                            // Step 3: Firestore에 review 업데이트
//                            FirestoreManager.shared.upsertReview(performId: review.performanceId, writerId: review.writerId, review: review) { reviewResult in
//                                switch reviewResult {
//                                case .success():
//                                    updateUserEmpathyCount(for: review.writerId, increment: isLike)
//                                    // 토글됬으니 반대로
//                                    // Step 4: Firestore에 유저 정보 업데이트
//                                    FirestoreManager.shared.updateUser(updatedUser) { userResult in
//                                        switch userResult {
//                                        case .success():
//                                            // Firestore에 업데이트가 완료된 후, UI를 메인 쓰레드에서 갱신
//                                            DispatchQueue.main.async {
//                                                userManager.user = updatedUser  // 업데이트된 유저 정보로 교체
//                                                print("User Like Review update success")
//                                            }
//                                        case .failure(let error):
//                                            print("User Like Review update failure: \(error.localizedDescription)")
//                                        }
//                                    }
//                                    print("LikeCount update success")
//                                case .failure(let error):
//                                    print("LikeCount update failure: \(error.localizedDescription)")
//                                }
//                            }
//
//                        }, label: {
//                            HStack(spacing: 2) {
//                                Image(systemName: isLike ? "hand.thumbsup.fill" : "hand.thumbsup")
//                                    .foregroundStyle(.nineYellow)
//                                Text("\(review.likeCount)")
//                                    .foregroundStyle(.nineYellow)
//                                    .font(.system(size: 14))
//                            }
//                        })
//                        
//                        Spacer()
//                        
//                        Button(action: {
//                            // GPT가 추가해줄 버튼!
//                        }, label: {
//                            Image(systemName: "ellipsis")
//                                .foregroundStyle(.gray)
//                        })
//                    }
//                }
//                .padding()
//                .background(
//                    RoundedRectangle(cornerRadius: 16)
//                        .fill(.nineDarkGray)
//                )
//                .onAppear {
//                    if let user = userManager.user {
//                        for reviewId in user.likeReviewIdList {
//                            if reviewId == self.review.id {
//                                isLike = true
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        
//        
//        private func updateUserEmpathyCount(for writerId: String, increment: Bool) {
//            FirestoreManager.shared.fetchUserById(userId: writerId) { result in
//                switch result {
//                case .success(var user):
//                    // likeCount 증가 시 empathyCount 증가, 감소 시 empathyCount 감소
//                    user.empathyCount += increment ? 1 : -1
//
//                    // 업데이트된 유저 정보 Firestore에 저장
//                    FirestoreManager.shared.updateUser(user) { updateResult in
//                        switch updateResult {
//                        case .success():
//                            DispatchQueue.main.async {
//                                userManager.user = user  // 업데이트된 유저 정보로 교체
//                                print("User Like Review update success")
//                            }
//                            print("Writer's empathyCount updated successfully in Firestore")
//                            // 여기서 userManager.user를 업데이트하지 않음
//                        case .failure(let error):
//                            print("Failed to update writer's empathyCount in Firestore: \(error.localizedDescription)")
//                        }
//                    }
//                case .failure(let error):
//                    print("Failed to fetch writer for updating empathyCount: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
//    
//    private struct StarRatingView: View {
//        var rating: Double
//        
//        var body: some View {
//            HStack(spacing: 1) {
//                ForEach(0..<5) { index in
//                    self.starType(for: index)
//                        .foregroundColor(.nineYellow)
//                }
//                
//                Text(String(format: "%.1f", rating))
//                    .font(.system(size: 14))
//                    .foregroundStyle(.nineYellow)
//            }
//        }
//        
//        func starType(for index: Int) -> Image {
//            let starValue = Double(index) + 1
//            
//            if rating >= starValue {
//                return Image(systemName: "star.fill")
//            } else if rating >= starValue - 0.5 {
//                return Image(systemName: "star.leadinghalf.filled")
//            } else {
//                return Image(systemName: "star")
//            }
//        }
//    }
//    
//    private struct ExpandableTextView: View {
//        let text: String
//        @State private var isExpanded: Bool = false
//        
//        var body: some View {
//            VStack(alignment: .leading) {
//                Text(text)
//                    .font(.body)
//                    .lineLimit(isExpanded ? nil : 2)
//                    .foregroundColor(.white)
//                    .onTapGesture {
//                        withAnimation {
//                            isExpanded.toggle()
//                        }
//                    }
//            }
//        }
//    }
//
//    private struct SegmentedCountryView: View {
//        @Binding var selection: Country
//        
//        var body: some View {
//            ScrollView(.horizontal) {
//                HStack {
//                    Button(action: {
//                        selection = .ALL
//                    }, label: {
//                        Text("All")
//                            .font(.system(size: 16))
//                            .foregroundStyle(selection == .ALL ? .nineBlack : .white)
//                            .padding(.horizontal, 32)
//                            .padding(.vertical, 8)
//                            .background(selection == .ALL ? .nineYellow : .nineDarkGray)
//                            .cornerRadius(55)
//                    })
//                    
//                    Button(action: {
//                        selection = .USA
//                    }, label: {
//                        Text("🇺🇸 USA")
//                            .font(.system(size: 16))
//                            .foregroundStyle(selection == .USA ? .nineBlack : .white)
//                            .padding(.horizontal, 16)
//                            .padding(.vertical, 8)
//                            .background(selection == .USA ? .nineYellow : .nineDarkGray)
//                            .cornerRadius(55)
//                    })
//                    
//                    Button(action: {
//                        selection = .CHN
//                    }, label: {
//                        Text("🇨🇳 CHN")
//                            .font(.system(size: 16))
//                            .foregroundStyle(selection == .CHN ? .nineBlack : .white)
//                            .padding(.horizontal, 16)
//                            .padding(.vertical, 8)
//                            .background(selection == .CHN ? .nineYellow : .nineDarkGray)
//                            .cornerRadius(55)
//                    })
//                    
//                    Button(action: {
//                        selection = .JPN
//                    }, label: {
//                        Text("🇯🇵 JPN")
//                            .font(.system(size: 16))
//                            .foregroundStyle(selection == .JPN ? .nineBlack : .white)
//                            .padding(.horizontal, 16)
//                            .padding(.vertical, 8)
//                            .background(selection == .JPN ? .nineYellow : .nineDarkGray)
//                            .cornerRadius(55)
//                    })
//                }
//            }
//            .padding(.vertical, 16)
//        }
//    }
//    
//    
//}
//
////#Preview {
////    DetailReviewView(reviews: <#T##Binding<[Review]>#>, perform: <#T##Binding<Performance>#>)
////}
