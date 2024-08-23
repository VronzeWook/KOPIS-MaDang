//
//  MaDangApp.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import AuthenticationServices

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Firebase 초기화
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct MaDangApp: App {
    @State private var performs: [Performance] = []
    //@State private var isUserLoggedIn = false
        
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var userManager: UserManager = UserManager()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.black
        UITabBar.appearance().barTintColor = UIColor.black
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                if !userManager.isUserLoggedIn {
                    LoginView()
                } else {
                    MainTabView(performs: $performs)
                        .onAppear {
                            let shared = KopisNetworkingManager.shared

                            shared.fetchPerformList(startDate: "20240801", endDate: "20240831", row: 20) { result in
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
            .environmentObject(userManager)
        }
    }
    
}
