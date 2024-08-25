//
//  MyReviewRow.swift
//  MaDang
//
//  Created by 추서연 on 8/20/24.
//



import SwiftUI

struct MyReviewRow: View {
    let review: Review

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: review.createdDate)
    }

    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let imageWidth = screenWidth * 3 / 10
        let aspectRatio: CGFloat = 135 / 100
        
        HStack {
//            Image("kopisTestImage") // Replace with actual image if needed
//                .resizable()
//                .scaledToFit()
//                .cornerRadius(10)
//                .frame(width: imageWidth, height: imageWidth * aspectRatio)
//
            AsyncImage(url: URL(string: review.posterUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
            } placeholder: {
                Color.gray
            }
            
            VStack(alignment: .leading) {
                Text(review.performanceTitle)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.top, 4)
                    .padding(.bottom, 2)
                Text(formattedDate)
                    .font(.system(size: 12))
                    .foregroundStyle(.gray)
                    .padding(.bottom, 2)
                    //.padding(.horizontal,15)
                
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
                
                Spacer()
            }
            .padding(.leading, 8)
        }
        .background(Color.nineDarkGray)
        .cornerRadius(10)
    }
}

extension MyReviewRow {
    private struct StarRatingView: View {
        var rating: Double
        
        var body: some View {
            HStack(spacing: 1) {
                ForEach(0..<5) { index in
                    self.starType(for: index)
                        .foregroundColor(.yellow)
                }
                
                Text(String(format: "%.1f", rating))
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)
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
    MyReviewRow(review: Review(performanceId: "idasf", performanceTitle: "재밌는 공연", posterUrl: "no", writerId: "dd", writerCountry: .USA, writerName: "Me", createdDate: Date(), content: "asdfasldjfaogihwori wpeihgoa. w. wiheo ", likeCount: 4, starRating: 2.5, isReported: false))
}
