//
//  DetailView.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var perform: Performance
    
    var body: some View {
        ScrollView {
            DetailInfoView(perform: $perform)
                .padding(.bottom, 96)
            DetailImageView(perform: $perform)
            DetailReviewView(perform: $perform)
            DetailCastingView(numberOfCircles: 7, perform: $perform)
        }
        .background(.nineBlack)
    }
}

#Preview {
    DetailView(perform: .constant(Performance.performList[0]))
}
