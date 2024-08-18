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
    @State private var performs: [Performance] = []

    var body: some View {
        NavigationStack{
            ScrollView {
                    VStack {
                        WhatIsNewView(performs: $performs)
                            .padding(.bottom, 8)
                        
                        PopularityRankingView(performs: $performs)
                            .padding(.top, 16)
                            .border(.nineYellow)
                        
                        GenreView(currentGenre: $currentGenre, performs: $performs)
                            
                        BestReviewView()
                            .padding(.top, 64)
                    }
                    .border(.green)
                    .background(.nineBlack)
            }
            .background(.black)
            .onAppear {
                let shared = KopisNetworkingManager.shared
                // 임의 조건 설정
                shared.fetchPerformList(startDate: "20240601", endDate: "20240631", row: 9, genreCode: Genre.Theater.code) { result in
                     switch result {
                     case .success(let performs) :
                         print("success")
                         self.performs = performs
                         
                     case .failure(_):
                         print("failure")
                     }
                 }
            }
        }
    }
}

#Preview {
    MainView()
}
