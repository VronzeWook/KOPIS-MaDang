//
//  BestReviewView.swift
//  MaDang
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct BestReviewView: View {
    
    let performs: [Performance] = Performance.performList
    let reviews: [Review] = Review.reviews
    
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
    }
}

#Preview {
    BestReviewView()
}
