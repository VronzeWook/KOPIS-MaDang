import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var showingAlert = false
    @State private var navigateToRegister = false

    var body: some View {
        VStack {

            Spacer()

            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(height: 60)
                .padding(.bottom, 48)

            TextField("Enter your email", text: $email)
                .padding()
                //.background(Color.nineBlack)
                .foregroundColor(.white) // 입력된 텍스트의 색상을 흰색으로 설정
                .placeholder(when: email.isEmpty) {
                    Text("Enter your email")
                        .foregroundColor(.nineDarkGray)
                        .padding(.leading, 16)// 플레이스홀더 색상을 .nineDarkGray로 설정
                }
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.nineDarkGray, lineWidth: 1)
                )
                .padding(.bottom, 10)

            SecureField("Enter your password", text: $password)
                .padding()
                //.background(Color.nineBlack)
                .foregroundColor(.white) // 입력된 텍스트의 색상을 흰색으로 설정
                .placeholder(when: password.isEmpty) {
                    Text("Enter your password")
                        .foregroundColor(.nineDarkGray)
                        .padding(.leading, 16)
                }
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.nineDarkGray, lineWidth: 1)
                )
                .padding(.bottom, 15)
            
            Button(action: {
                loginUser()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 360, height: 60)
                        .foregroundStyle(.nineDarkGray)
  
                        Text("LOGIN")
                            .bold()
                            .foregroundColor(.nineYellow)
                            .padding()
                            .background(.nineDarkGray)
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity)

                }
            }
            .padding(.horizontal)
            .padding(.top, 8)

            NavigationLink {
                RegisterView()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 360, height: 60)
                        .foregroundStyle(.nineDarkGray)

                        Text("REGISTER")
                            .bold()
                            .foregroundColor(.nineYellow)
                            .padding()
                            .background(.nineDarkGray)
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity)

                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Login Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .padding(.horizontal)
            .padding(.top, 8)
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 8)
        //.edgesIgnoringSafeArea(.all)
        .background(Color.nineBlack)
    }

    func loginUser() {
        userManager.loginUser(email: email, password: password) { success in
            if !success {
                self.errorMessage = "Login failed. Please check your email and password."
                self.showingAlert = true
            }
        }
    }
}

// 플레이스홀더를 처리하기 위한 커스텀 뷰 모디파이어
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            if shouldShow {
                placeholder()
            }
            self
        }
    }
}
//
//#Preview {
//    NavigationStack {
//        LoginView()
//            .environmentObject(UserManager())
//    }
//}
