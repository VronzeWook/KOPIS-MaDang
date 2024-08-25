import Foundation
import FirebaseAuth

final class UserManager: ObservableObject {
    @Published var user: User?
    @Published var fUser: FirebaseAuth.User?
    @Published var isUserLoggedIn: Bool = false // @Published로 선언하여 상태 변경 시 뷰 업데이트

    init() {
        checkLoginStatus()
    }
    
    // MARK: - 사용자 로그인 상태 체크
    func checkLoginStatus() {
        if let currentUser = Auth.auth().currentUser {
            // 사용자가 로그인되어 있음
            self.fUser = currentUser
            self.isUserLoggedIn = true
            // user 요청
            guard let f = fUser else {return}
            FirestoreManager.shared.fetchUserById(userId: f.uid) { [weak self] result in
                switch result {
                case .success(let user):
                    self?.user = user
                case .failure(let error):
                    print("Error fetching user data: \(error.localizedDescription)")
                    self?.user = nil
                }
            }
        } else {
            // 사용자가 로그인되어 있지 않음
            self.user = nil
            self.isUserLoggedIn = false
        }
    }
    
    // MARK: - 사용자 로그인
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
    
    // MARK: - 사용자 로그아웃
    func logoutUser() {
        do {
            try Auth.auth().signOut()
            self.fUser = nil
            self.isUserLoggedIn = false
        } catch {
            print("Logout Error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - 사용자 삭제 메서드
     func deleteUser(completion: @escaping (Result<Void, Error>) -> Void) {
         guard let fUser = fUser else {
             completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No authenticated user"])))
             return
         }

         // Firestore에서 사용자 정보 삭제
         FirestoreManager.shared.deleteUser(userId: fUser.uid) { [weak self] result in
             switch result {
             case .success:
                 // Firebase Auth에서 사용자 삭제
                 fUser.delete { error in
                     if let error = error {
                         print("Error deleting Firebase Auth user: \(error.localizedDescription)")
                         completion(.failure(error))
                     } else {
                         // 삭제 성공 시 상태 초기화
                         self?.fUser = nil
                         self?.user = nil
                         self?.isUserLoggedIn = false
                         completion(.success(()))
                         print("User deleted successfully from Firebase Auth")
                     }
                 }
             case .failure(let error):
                 completion(.failure(error))
             }
         }
     }

}
