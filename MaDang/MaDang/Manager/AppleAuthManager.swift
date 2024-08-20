//
//  AppleAuthManager.swift
//  MaDang
//
//  Created by LDW on 8/20/24.
//


import Foundation
import AuthenticationServices
import FirebaseAuth
import CryptoKit

// MARK: - AppleLogin 관련 속성 및 메서드 관리
final class AppleAuthManager: ObservableObject {
    @Published var authState = AuthState.signedOut
    
    // 현재 기기에 저장된 유저가 있는지 useridentifier를 이용해서 검사  후 로그인 상태를 반영
    func checkForExistingUser() {
        if let userIdentifier = KeychainHelper.shared.readUserIdentifier() {
            print("User already signed in with userIdentifier: \(userIdentifier)")
            authState = .signedIn
        } else {
            print("No stored userIdentifier, user needs to sign in.")
        }
    }

    // SignInWithAppleButton의 request에 대해 success 응답이 왔을 때 실행
    func handleSuccessfulLogin(with authorization: ASAuthorization, rawNonce: String?) {
        if let userCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = userCredential.user // 아래 예시 중 userIdentifier 사용
            KeychainHelper.shared.saveUserIdentifier(userIdentifier) // 저장
            print(userCredential.user)
//             파이어베이스 로직 추가
            
            // Firebase에 Apple ID로 인증
               guard let identityToken = userCredential.identityToken else {
                   print("Unable to fetch identity token")
                   return
               }
               
               guard let tokenString = String(data: identityToken, encoding: .utf8) else {
                   print("Unable to serialize token string from data: \(identityToken.debugDescription)")
                   return
               }

               // Nonce 값이 nil이 아닌지 확인
               guard let nonce = rawNonce else {
                   print("Invalid state: A login callback was received, but no login request was sent.")
                   return
               }

               // Firebase Credential 생성
               let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
               
               // Firebase로 인증 진행
               Auth.auth().signIn(with: firebaseCredential) { authResult, error in
                   if let error = error {
                       print("Firebase sign in failed: \(error.localizedDescription)")
                       self.authState = .signedOut
                       return
                   }
                   print("User is signed in to Firebase with Apple")
                   self.authState = .signedIn
               }
            
            
//            응답으로 받은 계정 정보 종류
//            let UserIdentifier = userCredential.user
//            let fullName = userCredential.fullName
//            let name =  (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
//            let email = userCredential.email
//            let IdentityToken = String(data: userCredential.identityToken!, encoding: .utf8)
//            let AuthorizationCode = String(data: userCredential.authorizationCode!, encoding: .utf8)
            
            // 정보 출력
            if userCredential.authorizedScopes.contains(.fullName) {
                print(userCredential.fullName?.givenName ?? "No given name")
            }
            
            if userCredential.authorizedScopes.contains(.email) {
                print(userCredential.email ?? "No email")
            }
        }
    }
    
    // SignInWithAppleButton의 request에 대해 fail 응답이 왔을 때 실행
    func handleLoginError(with error: Error) {
        print("Could not authenticate: \\(error.localizedDescription)")
    }
    
    func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
        }
        
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        let nonce = randomBytes.map { byte in
            charset[Int(byte) % charset.count]
        }
        return String(nonce)
    }
    
    @available(iOS 13, *)
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        return hashedData.compactMap { String(format: "%02x", $0) }.joined()
    }
}

enum AuthState {
    case signedIn
    case signedOut
}
