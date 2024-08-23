import SwiftUI
import FirebaseAuth

struct MainView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var currentGenre: Genre = .All
    @State private var isModalPresented: Bool = false
    @State private var isLangModalPresented: Bool = false
    @State private var currentLang: Language = .Korean
    @State private var showReauthAlert = false
    @State private var reauthPassword = ""
    @Binding var performs: [Performance]

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        MainHeader(currentLang: $currentLang, isLangModalPresented: $isLangModalPresented)

                        WhatIsNewView(performs: $performs)
                            .padding(.bottom, 8)

                        PopularityRankingView(performs: $performs)
                            .padding(.top, 16)
                            .border(.nineYellow)

                        GenreView(currentGenre: $currentGenre, performs: $performs)

                        BestReviewView()
                            .padding(.top, 64)

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
                    .border(.green)
                    .background(.nineBlack)
                }
                .background(.black)
            }

            if isLangModalPresented {
                Color.clear
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isModalPresented.toggle()
                    }

                LangModalView(showModal: $isLangModalPresented, selectedLang: $currentLang)
                    .background(.nineBlack)
                    .animation(.easeInOut, value: isLangModalPresented)
            }
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
    MainView(performs: .constant(Performance.performList))
        .environmentObject(UserManager())
}
