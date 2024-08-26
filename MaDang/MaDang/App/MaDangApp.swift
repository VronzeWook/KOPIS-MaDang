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
//
//@main
//struct MaDangApp: App {
//    @State private var performs: [Performance] = []
//    //@State private var isUserLoggedIn = false
//        
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    @StateObject private var userManager: UserManager = UserManager()
//    
//    init() {
//        UITabBar.appearance().backgroundColor = UIColor.black
//        UITabBar.appearance().barTintColor = UIColor.black
//    }
//    
//    var body: some Scene {
//        WindowGroup {
//            NavigationStack {
//                if !userManager.isUserLoggedIn {
//                    LoginView()
//                } else {
//                    MainTabView(performs: $performs)
//                        .onAppear {
//                            let shared = KopisNetworkingManager.shared
//                            
//                            shared.fetchPerformList(startDate: "20240801", endDate: "20240831", row: 20) { result in
//                                switch result {
//                                case .success(let performs) :
//                                    print("success")
//                                    self.performs = performs
//                                    
//                                case .failure(_):
//                                    print("failure")
//                                }
//                            }
//                            
//                            // 유저 정보 갱신
//                            userManager.checkLoginStatus()
//                        }
//                }
//            }
//            .environmentObject(userManager)
//        }
//    }
//    
//}

@main
struct MaDangApp: App {
    @State private var performs: [Performance] = []
        
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var userManager: UserManager = UserManager()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.black
        UITabBar.appearance().barTintColor = UIColor.black
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if !userManager.isUserLoggedIn {
                    LoginView()
                        .background(.nineBlack)
                } else {
                    MainTabView(performs: $performs)
                        .onAppear {
                            fetchAndStorePerforms()
                            // 유저 정보 갱신
                            userManager.checkLoginStatus()
                        }
                }
            }
            .environmentObject(userManager)
        }
    }
    
    private func fetchAndStorePerforms() {
        let shared = KopisNetworkingManager.shared
        
        shared.fetchPerformList(startDate: "20240801", endDate: "20240831", row: 20) { result in
            switch result {
            case .success(let fetchedPerforms):
                self.performs = fetchedPerforms
                checkAndStorePerformances(fetchedPerforms)
                
            case .failure(_):
                print("failure")
            }
        }
    }
    
    private func checkAndStorePerformances(_ fetchedPerforms: [Performance]) {
        // Step 1: Firestore에서 이미 저장된 Performance ID 목록 가져오기
        FirestoreManager.shared.fetchAllPerformanceIds { result in
            switch result {
            case .success(let storedPerformanceIds):
                // Step 2: KopisNetworkingManager에서 불러온 Performance와 비교
                let newPerforms = fetchedPerforms.filter { !storedPerformanceIds.contains($0.id) }
                
                // Step 3: Firestore에 없는 Performance 등록
                for perform in newPerforms {
                    FirestoreManager.shared.upsertPerformance(performance: perform) { result in
                        switch result {
                        case .success():
                            print("Performance \(perform.title) 등록 성공")
                        case .failure(let error):
                            print("Performance \(perform.title) 등록 실패: \(error.localizedDescription)")
                        }
                    }
                }
                
            case .failure(let error):
                print("Failed to fetch stored performance IDs: \(error.localizedDescription)")
            }
        }
    }
}
