//
//  GPTTesttView.swift
//  MaDang
//
//  Created by 추서연 on 8/23/24.
//

import SwiftUI

struct GPTTestView: View {
    @StateObject private var gptManager = GPTManager()
    @State private var inputText: String = ""
    @State private var isLoading: Bool = false
    @State private var showErrorAlert: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter text to translate...", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if isLoading {
                    ProgressView("Translating...")
                        .padding()
                } else {
                    Button(action: {
                        translateText()
                    }) {
                        Text("번역 요청")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                }

                ScrollView {
                    Text(gptManager.response)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                       
                }

                Spacer()
            }
            .padding()
            .alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func translateText() {
        guard !inputText.isEmpty else { return }
        isLoading = true
        gptManager.sendMessage(from: inputText) { result in
            isLoading = false
            switch result {
            case .success:
                print("Translation successful")
            case .failure(let error):
                errorMessage = error.localizedDescription
                showErrorAlert = true
            }
        }
    }
}


#Preview{
    GPTTestView()
}
