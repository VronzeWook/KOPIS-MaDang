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
    
//    init() {
//            UITabBar.appearance().backgroundColor = UIColor.black
//            UITabBar.appearance().barTintColor = UIColor.black 
//        }

    
    var body: some View {
        TabView(selection: $selectedTab) {
            MainView(performs: $performs)
                .tabItem {
                    Image(systemName: "newspaper")
                    Text(Title.main.name)
                }
                .tag(0)
            
            RankingView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text(Title.ranking.name)
                }
                .tag(1)
            
        }
        .tint(Color(.nineYellow))
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor.black
            UITabBar.appearance().barTintColor = UIColor.black
        }
    }
    
}

#Preview {
    MainTabView(performs: .constant(Performance.performList))
}
