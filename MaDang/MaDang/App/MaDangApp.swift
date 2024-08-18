//
//  MaDangApp.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//

import SwiftUI

@main
struct MaDangApp: App {
    init() {
        DataManager.shared.fetchData()
    }
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
            MainView()
        }
    }
}
