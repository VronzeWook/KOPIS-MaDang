//
//  MainTabView.swift
//  MaDang
//
//  Created by 추서연 on 8/18/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Int = 0
    
    init() {
            UITabBar.appearance().backgroundColor = UIColor.black
            UITabBar.appearance().barTintColor = UIColor.black 
        }

    
    var body: some View {
        TabView(selection: $selectedTab) {
            MainView()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text(Title.main.name)
                }
                .tag(0)
            
            ByGenreView()
                .tabItem {
                    Image(systemName: "rectangle.3.group.fill")
                    Text(Title.genre.name)
                }
                .tag(1)
            RankingView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text(Title.ranking.name)
                }
                .tag(2)
            AccountView()
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
    MainTabView()
}
