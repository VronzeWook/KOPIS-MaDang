//
//  MadangApp.swift
//  MaDang
//
//  Created by 추서연 on 8/18/24.
//

import SwiftUI

@main
struct MadangApp: App {
    var body: some Scene {
        let managedObject = PersistentController.shared
        WindowGroup {
            ZStack {
               
                    SplashView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    showSplash = false
                                }
                            }
                        }
               
            }
        }
    }
}
