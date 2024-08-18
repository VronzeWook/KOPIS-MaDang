//
//  RankingView.swift
//  MaDang
//
//  Created by 추서연 on 8/18/24.
//

import SwiftUI

struct RankingView: View {
    @State private var currentRanking: Ranking = .Likes

    var body: some View {
        ScrollView {
                LogoHeader(currentRanking: $currentRanking)
                LangSelectionView()
                RankingListView(performs: Performance.performList)
        }
        .background(.nineBlack)
    }
}

#Preview {
    RankingView()
}
