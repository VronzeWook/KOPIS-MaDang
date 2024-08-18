//
//  RankingRow.swift
//  MaDang
//
//  Created by 추서연 on 8/18/24.
//

import SwiftUI

struct RankingRow: View {
    
    // let perform: Performance = Performance.performList[0]
    let review: Review
    
    var body: some View {
        
        let screenWidth = UIScreen.main.bounds.width
        let imageWidth = screenWidth * 3 / 10
        let aspectRatio: CGFloat = 135 / 100
        let rank: Int
        
        HStack{
            
            
            VStack {
                
//                Text("\(rank)")
//                    .foregroundColor(Color.yellow.opacity(0.5))
//                    .fontWeight(.bold)
//                    .font(.system(size: 110))
//                    .offset(x: -20, y: 23)
                
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
            Image("kopisTestImage")
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .frame(width: imageWidth, height: imageWidth * aspectRatio)
            
        }
        .background(.nineDarkGray)
        .cornerRadius(10)
    }

}

extension RankingRow {
    private struct StarRatingView: View {
        var rating: Double

        
        var body: some View {
            
            VStack{
                
                HStack (spacing: 0){
                    ForEach(0..<5) { index in
                        self.starType(for: index)
                            .foregroundColor(.nineYellow)
                            .font(.system(size: 14))
                    }
                    
                    Text(String(format: "%.2f", rating))
                        .padding(.top,5)
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .foregroundStyle(.nineYellow)
                        .padding(.leading, 10)
                }
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
    RankingRow(review: Review.reviews[0])
}
