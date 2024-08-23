import Foundation
import FirebaseAuth

final class UserManager: ObservableObject {
    @Published var user: User?
    @Published var fUser: FirebaseAuth.User?
    @Published var isUserLoggedIn: Bool = false // @Published로 선언하여 상태 변경 시 뷰 업데이트

    init() {
        checkLoginStatus()
    }
    
    func checkLoginStatus() {
        if let currentUser = Auth.auth().currentUser {
            // 사용자가 로그인되어 있음
            self.fUser = currentUser
            self.isUserLoggedIn = true
        } else {
            // 사용자가 로그인되어 있지 않음
            self.user = nil
            self.isUserLoggedIn = false
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                print("Login Error: \(error.localizedDescription)")
                completion(false)
            } else if let user = authResult?.user {
                self?.fUser = user
                self?.isUserLoggedIn = true
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func logoutUser() {
        do {
            try Auth.auth().signOut()
            self.fUser = nil
            self.isUserLoggedIn = false
        } catch {
            print("Logout Error: \(error.localizedDescription)")
        }
    }
    
}
