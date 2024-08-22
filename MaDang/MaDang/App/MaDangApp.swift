//
//  MaDangApp.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct MaDangApp: App {
    @State private var performs: [Performance] = []
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authManager: AppleAuthManager = AppleAuthManager()
    @StateObject private var userManager: UserManager = UserManager()
    
    var userId: String {
           return Auth.auth().currentUser?.uid ?? "Unknown User"
       }
    
    var body: some Scene {
        WindowGroup {
//            GPTTestView()
            MainTabView(performs: $performs)
                .environmentObject(authManager)
                .environmentObject(userManager)
                .onAppear {
                    let shared = KopisNetworkingManager.shared
                    // 임의 조건 설정
                    //shared.fetchPerformList(startDate: "20240601", endDate: "20240831", row: 20, genreCode: Genre.Theater.code) { result in
                    shared.fetchPerformList(startDate: "20240801", endDate: "20240831", row: 20) { result in
                         switch result {
                         case .success(let performs) :
                             print("success")
                             self.performs = performs
                             
                         case .failure(_):
                             print("failure")
                         }
                     }
                    
                    // User 생성
                    let newUser = User(
                        id: userId,  // 사용자가 직접 설정한 ID
                        name: "Andrew",
                        country: .KOR,
                        reviewIdList: [],
                        likeReviewIdList: [],
                        likePerformIdList: []
                    )

                    FirestoreManager.shared.createUser(newUser) { result in
                        switch result {
                        case .success():
                            print("User created successfully.")
                        case .failure(let error):
                            print("Failed to create user: \(error.localizedDescription)")
                        }
                    }
                    
                    // User 일단 더미 설정
                    FirestoreManager.shared.fetchUserById(userId: userId) { result in
                        switch result {
                        case .success(let user) :
                            userManager.user = user
                            print("Set user success")
                        case .failure(_):
                            userManager.user?.name = "Unknowned"
                            print("Set user failure")
                        }
                    }
                }
        }
    }
}
