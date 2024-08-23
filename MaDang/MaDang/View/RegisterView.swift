import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var name: String = ""
    @State private var selectedCountry: Country = .ALL
    @State private var emailValidationMessage: String = ""
    @State private var passwordValidationMessage: String = ""
    @State private var confirmPasswordMessage: String = ""
    @State private var errorMessage: String = ""
    @State private var showingAlert = false

    var body: some View {
        VStack {
            Text("Register")
                .font(.largeTitle)
                .padding()

            TextField("Enter your name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SegmentedCountryView(selection: $selectedCountry)
            
            TextField("Enter your email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: email) { _ in
                    self.emailValidationMessage = validateEmail() ? "Email is valid" : "Please enter a valid email address."
                }

            Text(emailValidationMessage)
                .foregroundColor(validateEmail() ? .green : .red)
                .padding(.horizontal)

            SecureField("Enter your password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: password) { _ in
                    self.passwordValidationMessage = validatePassword() ? "Password is valid" : "Password must be at least 8 characters long, containing at least one letter, one number, and one special character."
                }

            Text(passwordValidationMessage)
                .foregroundColor(validatePassword() ? .green : .red)
                .padding(.horizontal)

            SecureField("Confirm your password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: confirmPassword) { _ in
                    self.confirmPasswordMessage = passwordsMatch() ? "Passwords match" : "Passwords do not match."
                }

            Text(confirmPasswordMessage)
                .foregroundColor(passwordsMatch() ? .green : .red)
                .padding(.horizontal)

            Button(action: registerUser) {
                Text("Register")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
            }
            .disabled(!canRegister())
            .opacity(canRegister() ? 1 : 0.5)
            .padding()

            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Registration Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }

    func registerUser() {
        guard canRegister() else { return }

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    self.showingAlert = true
                } else if let authResult = authResult {
                    // Registration successful, now save the user data to Firestore
                    saveUserToFirestore(uid: authResult.user.uid)
                }
            }
        }
    }

    func saveUserToFirestore(uid: String) {
        let db = Firestore.firestore()
        
        let user = User(
            id: uid,
            name: name, // Use the entered name
            email: email,
            country: selectedCountry, // Use the selected country
            reviewIdList: [],
            likeReviewIdList: [],
            likePerformIdList: []
        )

        do {
            try db.collection("users").document(uid).setData(from: user) { error in
                if let error = error {
                    self.errorMessage = "Error saving user data: \(error.localizedDescription)"
                    self.showingAlert = true
                } else {
                    self.presentationMode.wrappedValue.dismiss()
                    print("User registered and data saved to Firestore successfully!")
                }
            }
        } catch let error {
            self.errorMessage = "Error saving user data: \(error.localizedDescription)"
            self.showingAlert = true
        }
    }

    func validateEmail() -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

    func validatePassword() -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }

    func passwordsMatch() -> Bool {
        return password == confirmPassword && !password.isEmpty
    }

    func canRegister() -> Bool {
        return !name.isEmpty && validateEmail() && validatePassword() && passwordsMatch()
    }
    
    private struct SegmentedCountryView: View {
        @Binding var selection: Country
        
        var body: some View {
            ScrollView(.horizontal) {
                HStack {
                    Button(action: {
                        selection = .USA
                    }, label: {
                        Text("🇺🇸 USA")
                            .font(.system(size: 16))
                            .foregroundStyle(selection == .USA ? .nineBlack : .white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(selection == .USA ? .nineYellow : .nineDarkGray)
                            .cornerRadius(55)
                    })
                    
                    Button(action: {
                        selection = .CHN
                    }, label: {
                        Text("🇨🇳 CHN")
                            .font(.system(size: 16))
                            .foregroundStyle(selection == .CHN ? .nineBlack : .white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(selection == .CHN ? .nineYellow : .nineDarkGray)
                            .cornerRadius(55)
                    })
                    
                    Button(action: {
                        selection = .JPN
                    }, label: {
                        Text("🇯🇵 JPN")
                            .font(.system(size: 16))
                            .foregroundStyle(selection == .JPN ? .nineBlack : .white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(selection == .JPN ? .nineYellow : .nineDarkGray)
                            .cornerRadius(55)
                    })
                }
            }
            .padding(.vertical, 16)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
