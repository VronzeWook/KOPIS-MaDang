//
//  MainView.swift
//  MaDang
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct MainView: View {
    
    @State private var currentGenre: Genre = .All
    @State private var isModalPresented: Bool = false
    let performs: [Performance] = Performance.performList
    
    var body: some View {
        NavigationStack{
            ScrollView {
                    VStack {
                        WhatIsNewView()
                            .padding(.bottom, 8)
                        
                        PopularityRankingView(performs: performs )
                            .padding(.top, 16)
                            .border(.nineYellow)
                        
                        GenreView(currentGenre: $currentGenre)
                            
                        BestReviewView()
                            .padding(.top, 64)
                    }
                    .border(.green)
                .background(.nineBlack)
            }
        }
    }
}

#Preview {
    MainView()
}
