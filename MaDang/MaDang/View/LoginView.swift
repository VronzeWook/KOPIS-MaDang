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
            Text("Login")
                .font(.largeTitle)
                .padding()

            TextField("Enter your email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Enter your password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                loginUser()
            }) {
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
            }
            .padding()

            Button(action: {
                navigateToRegister = true
            }) {
                Text("Register")
                    .foregroundColor(.blue)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .padding(.bottom)

            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Login Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
        .background(
            NavigationLink(
                destination: RegisterView(),
                isActive: $navigateToRegister,
                label: { EmptyView() }
            )
        )
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

#Preview {
    NavigationStack {
        LoginView()
            .environmentObject(UserManager())
    }
}
