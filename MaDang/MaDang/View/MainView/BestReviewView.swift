//
//  BestReviewView.swift
//  MaDang
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct BestReviewView: View {
    
    let performs: [Performance] = Performance.performList
    let shared = FirestoreManager.shared
    @State private var reviews: [Review] = []
    
    var body: some View {
        let bestReviews = reviews.prefix(4)
        
        VStack{
            HStack{
                Text("Best Reviews")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
            }
            
            ForEach(bestReviews, id: \.id) { review in
                NavigationLink {
                    
                } label: {
                    BestReviewRow(review: review)
                        .padding(.bottom, 8)
                }
            }
            
        }
        .background(.nineBlack)
        .onAppear {
            // 테스트 요청
            shared.fetchReviewsOrderedByLikes { result in
                
                switch result {
                case .success(let reveiws):
                    self.reviews = reviews
                case .failure(_):
                    print("failed to fetch reveiw in BestReviewView")
                }

            }
        }
    }
}

#Preview {
    BestReviewView()
}
