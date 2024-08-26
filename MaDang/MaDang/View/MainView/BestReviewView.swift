//
//  BestReviewView.swift
//  MaDang
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct BestReviewView: View {
    
    let shared = FirestoreManager.shared
    @State private var reviews: [Review] = []
    
    var body: some View {
        let bestReviews = reviews.prefix(3) // 상위 3개의 리뷰만 표시
        
        VStack{
            HStack{
                Text("Best Reviews")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
            }
            
            ForEach(bestReviews, id: \.id) { review in
//                NavigationLink {
//                    // 리뷰 상세 페이지로 이동하도록 설정
//                    
//                    
//                } label: {
                    BestReviewRow(review: review)
                        .padding(.bottom, 8)
//                }
            }
        }
        .background(.nineBlack)
        .onAppear {
            // 좋아요 수가 높은 리뷰를 요청
            shared.fetchReviewsOrderedByLikes { result in
                switch result {
                case .success(let reviews):
                    self.reviews = reviews
                case .failure(let error):
                    print("Failed to fetch reviews in BestReviewView: \(error.localizedDescription)")
                }
            }
            
            
        }
    }
}

#Preview {
    BestReviewView()
}

