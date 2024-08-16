//
//  DetailView.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        ScrollView {
                DetailInfoView()
                .padding(.bottom, 96)
                DetailImageView()
                DetailReviewView()
                DetailCastingView(numberOfCircles: 7)
        }
        .background(.nineBlack)
    }
}

#Preview {
    DetailView()
}
