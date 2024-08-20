//
//  BestReviewRow.swift
//  MaDang
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct BestReviewRow: View {

    // let perform: Performance = Performance.performList[0]
    let review: Review
    
    var body: some View {
        
        let screenWidth = UIScreen.main.bounds.width
        let imageWidth = screenWidth * 3 / 10
        let aspectRatio: CGFloat = 135 / 100
        
        HStack{
            Image("kopisTestImage")
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .frame(width: imageWidth, height: imageWidth * aspectRatio)
            
            VStack {
                HStack {
                    StarRatingView(rating: review.starRating)
                        .padding(.bottom, 4)
                    
                    Spacer()
                }
                Text(review.content)
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
            }
            
        }
        .background(.nineDarkGray)
        .cornerRadius(10)
    }

}

extension BestReviewRow {
    private struct StarRatingView: View {
        var rating: Double
        
        var body: some View {
            HStack(spacing: 1) {
                ForEach(0..<5) { index in
                    self.starType(for: index)
                        .foregroundColor(.nineYellow)
                }
                
                Text(String(format: "%.1f", rating))
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .foregroundStyle(.nineYellow)
                    .padding(.leading, 4)
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

#Preview {
    BestReviewRow(review: Review(id: UUID().uuidString, performanceId: Performance.performList[0].id, writerId: UUID().uuidString, writerCountry: .USA, writerName: "joy", createdDate: Date(), content: "abcdefghijklmn op abcdef g hijk lmnop abc defg hijklmnop abcdefgh ijkl mnop  abcdefgh ijklmnop abcdefghijklmnop efghijklmnop abcdefghijklmnop abcdefghijklmnop abcdefghijklmnop abcdefghijklmnop abcdefghi", likeCount: 123, starRating: 4.5, isReported: false))
}
