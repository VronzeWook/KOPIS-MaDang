//
//  RankingCell.swift
//  MaDang
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct RankingCell: View {
    
    let rank: Int
    @Binding var perform: Performance
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let imageWidth = screenWidth * 1/4
        let aspectRatio: CGFloat = 173 / 123
        
        VStack{
            ZStack(alignment: .bottomLeading) {
                let url = perform.posterUrlList.isEmpty ? "" : perform.posterUrlList[0]
//                Image("kopisTestImage")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: imageWidth, height: imageWidth * aspectRatio)
                
                AsyncImage(url: URL(string: url)) {image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: imageWidth, height: imageWidth * aspectRatio)
                
                Text("\(rank)")
                    .foregroundColor(Color.yellow.opacity(0.5))
                    .fontWeight(.bold)
                    .font(.system(size: 110))
                    .offset(x: -20, y: 23)
            }
            
            Text(perform.title)
                .font(.system(size: 16))
                .frame(width: 123)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
        }
        
    }
}

#Preview {
    RankingCell(rank: 2, perform: .constant(Performance.performList[0]))
}
