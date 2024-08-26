//
//  RankingListView.swift
//  MaDang
//
//  Created by 추서연 on 8/18/24.
//

import SwiftUI

struct RankingListView: View {
    @Binding var performs: [Performance]
    @Binding var selection: Int
    
    var body: some View {
        ScrollView {
                VStack {
                    ForEach(performs.indices, id: \.self) { i in
                        VStack {
                            NavigationLink {
                                DetailView(perform: $performs[i])
                            } label: {
                                RankingListCell(rank: i + 1, perform: $performs[i], selection: selection)
                                    .padding(.horizontal, 16)
                            }
                        }
                        .frame(height: 180)
                    }
                }
                .padding(.top, 16)
                .background(.nineBlack)
            }
    }
}

#Preview {
    RankingListView(performs: .constant(Performance.performList), selection: .constant(0))
}
