//
//  RankingView.swift
//  MaDang
//
//  Created by 추서연 on 8/18/24.
//

import SwiftUI

struct RankingView: View {
    @State private var currentRanking: Ranking = .Likes
    @Binding var performs: [Performance]
    
    var body: some View {
        ScrollView {
            LogoHeader(currentRanking: $currentRanking)
            LangSelectionView()
            RankingListView(performs: $performs)
        }
        .background(.nineBlack)
    }
}

#Preview {
    RankingView(performs: .constant(Performance.performList))
}
