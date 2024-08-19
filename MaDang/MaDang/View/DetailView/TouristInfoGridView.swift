//
//  TouristInfoGridView.swift
//  MaDang
//
//  Created by LDW on 8/20/24.
//

import SwiftUI

struct TouristInfoGridView: View {

    // 상위 뷰에서 데이터를 1 ~ 4개로 받아올 것을 가정
    let infos: [TouristInfo]
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(0..<infos.count, id: \.self) { index in
                TouristInfoCell(touristInfo: infos[index])
            }
        }
        .padding()
    }
}

#Preview {
    TouristInfoGridView(infos: [])
}
