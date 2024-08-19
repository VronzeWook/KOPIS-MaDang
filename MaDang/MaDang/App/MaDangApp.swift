//
//  MaDangApp.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//

import SwiftUI

@main
struct MaDangApp: App {
    @State private var performs: [Performance] = []
    
    var body: some Scene {
        WindowGroup {
            MainTabView(performs: $performs)
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
