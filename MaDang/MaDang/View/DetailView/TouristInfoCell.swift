//
//  TouristInfoCell.swift
//  MaDang
//
//  Created by LDW on 8/20/24.
//

import SwiftUI

struct TouristInfoCell: View {
    
    var index: Int = 0
    // 나중에 객체 하나로 치환
    let touristInfo: TouristInfo
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let imageWidth = screenWidth * 45 / 100

        VStack {
            // touristInfo.imageUrl
            Image(touristInfo.imageUrl)
                .resizable()
                .frame(width: imageWidth, height: imageWidth)
                .cornerRadius(10)
            
            VStack {
                HStack{
                    Text(touristInfo.name)
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                    Spacer()
                }
                HStack{
                    Text(touristInfo.address)
                        .foregroundStyle(.gray)
                        .font(.system(size: 14))
                    Spacer()
                }
            }
        }
        .frame(width: imageWidth)
        .background(.nineBlack)
    }
}

#Preview {
    TouristInfoCell(touristInfo:
        TouristInfo(region: "InCheon", address: "Bupyeong-gu, Incheon", country: .USA, type: .restaurant, imageUrl: "kopisTestImage", name: "Bupyeong History Museum", detail: ""))
}
