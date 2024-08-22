//
//  TranslateTestView.swift
//  MaDang
//
//  Created by 추서연 on 8/23/24.
//

import SwiftUI
import UIKit

struct TranslateTestView: View {
    @StateObject private var viewModel = TextDetectionViewModel()
    @StateObject private var gptManager = GPTManager()
    @State private var uiImage: UIImage? = UIImage(named: "kopisTestImage")
    @State private var isGenerating: Bool = false
    @State private var rotation: Double = 0.0
    @State private var isLoading: Bool = false
    @State private var showErrorAlert: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        VStack {
            if let image = uiImage {
                ZStack(alignment: .topLeading) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            VStack(alignment: .leading) {
                                if !viewModel.detectedText.isEmpty {
                                    Text(viewModel.detectedText)
                                        .font(.caption)
                                        .foregroundColor(.white)
                                        .padding(5)
                                        .background(Color.black.opacity(0.7))
                                        .cornerRadius(5)
                                        .padding([.top, .leading], 10)
                                }
                            }
                        }
                        .onAppear {
                            viewModel.processImage(image)
                        }
                        .onChange(of: viewModel.detectedText) { newValue in
                            translateText()
                        }
                }
            } else {
                Text("No image found")
            }
        }
        .padding()
        .overlay {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
            }
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func translateText() {
        guard !viewModel.detectedText.isEmpty else { return }
        isLoading = true
        gptManager.sendMessage(from: viewModel.detectedText) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success:
                    print("Translation successful")
                    completeTranslate()
                case .failure(let error):
                    errorMessage = error.localizedDescription
                    showErrorAlert = true
                }
            }
        }
    }
    
    private func startTranslate() {
        print("start Translate")
        isGenerating = true
        withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
            rotation = 360
        }
    }
    
    private func completeTranslate() {
        print("complete Translate")
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        isGenerating = false
        // updateUserUsageInfo()
        withAnimation {
            rotation = 45
        }
    }
}

#Preview {
    TranslateTestView()
}

