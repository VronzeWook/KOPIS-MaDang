//
//  MainTabView.swift
//  MaDang
//
//  Created by 추서연 on 8/18/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Int = 0
    @Binding var performs: [Performance]


    var body: some View {

                TabView(selection: $selectedTab) {
                    MainView(performs: $performs, selectedTab: $selectedTab)
                        .tabItem {
                            Image(systemName: "newspaper")
                            Text(Title.main.name)
                        }
                        .tag(0)
                    
                    ByGenreView(performs: $performs)
                        .tabItem {
                            Image(systemName: "rectangle.3.group.fill")
                            Text(Title.genre.name)
                        }
                        .tag(1)
                    RankingView(performs: $performs)
                        .tabItem {
                            Image(systemName: "star.fill")
                            Text(Title.ranking.name)
                        }
                        .tag(2)
                    AccountView(performs: $performs)
                    // TranslateTestView()
                        .tabItem {
                            Image(systemName: "person.circle.fill")
                            Text(Title.account.name)
                        }
                        .tag(3)
                    
                    
                }
                .tint(Color(.nineYellow))
    }
}

#Preview {
    MainTabView(performs: .constant(Performance.performList))
}
