//
//  AccountView.swift
//  MaDang
//
//  Created by 추서연 on 8/20/24.
//

import SwiftUI
import FirebaseAuth

struct AccountView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var showReauthAlert = false
    @State private var reauthPassword = ""
    @Binding var performs: [Performance]
    
    var body: some View {
        ZStack {
            ScrollView {
                AccountProfile()
                    .padding(.bottom, 51)
                
                MyActivityList(performs: $performs)
                    .padding(.bottom, 51)
                
                CommunityList()
                
                Button {
                    userManager.logoutUser()
                    do {
                        try Auth.auth().signOut()
                    } catch let signOutError as NSError {
                        print("Error signing out: %@", signOutError)
                    }
                } label: {
                    Text("로그아웃")
                }
                .padding()
                
                Button {
                    showReauthAlert = true
                } label: {
                    Text("회원 탈퇴")
                        .foregroundColor(.red)
                }
                .padding()
                
            }
            .background(.nineBlack)
        }
        .alert("Re-authenticate to Delete Account", isPresented: $showReauthAlert) {
            SecureField("Enter your password", text: $reauthPassword)
            Button("Cancel", role: .cancel) { }
            Button("Confirm", role: .destructive) {
                reauthenticateAndDeleteUser()
            }
        } message: {
            Text("Please enter your password to confirm account deletion.")
        }
    }
    
    func reauthenticateAndDeleteUser() {
        guard let user = Auth.auth().currentUser, let email = user.email else { return }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: reauthPassword)
        
        user.reauthenticate(with: credential) { authResult, error in
            if let error = error {
                print("Reauthentication failed: \(error.localizedDescription)")
                return
            }
            
            userManager.deleteUser { result in
                switch result {
                case .success():
                    print("회원 탈퇴 성공")
                case .failure(let error):
                    print("회원 탈퇴 실패: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    AccountView(performs: .constant([]))
}
