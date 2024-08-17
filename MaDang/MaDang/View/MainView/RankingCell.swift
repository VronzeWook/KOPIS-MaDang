//
//  RankingCell.swift
//  MaDang
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct RankingCell: View {
    
    let title: String
    let rank: Int
    let imageUrl: String
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let imageWidth = screenWidth * 1/4
        let aspectRatio: CGFloat = 173 / 123
        
        VStack{
            ZStack(alignment: .bottomLeading) {
                Image("kopisTestImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageWidth, height: imageWidth * aspectRatio)
                Text("\(rank)")
                    .foregroundColor(Color.yellow.opacity(0.5))
                    .fontWeight(.bold)
                    .font(.system(size: 110))
                    .offset(x: -20, y: 23)
            }
            
            Text(title)
                .font(.system(size: 16))
                .frame(width: 123)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
        }
        
    }
}

#Preview {
    RankingCell(title: "A Store Selling Time", rank: 2, imageUrl: "url")
}
