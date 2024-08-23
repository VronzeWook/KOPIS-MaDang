//
//  TextAndTranslateManager.swift
//  MaDang
//
//  Created by 추서연 on 8/23/24.
//

import Foundation
import Combine
import UIKit

class TextAndTranslateManager: ObservableObject {
    @Published var detectedText: String = ""
    @Published var translatedText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var showErrorAlert: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    private let textDetectionViewModel = TextDetectionViewModel()
    private let gptManager = GPTManager()
    
    func processImage(_ image: UIImage) {
        textDetectionViewModel.processImage(image)
        
        textDetectionViewModel.$detectedText
            .sink { [weak self] text in
                self?.detectedText = text
                self?.translateText()
            }
            .store(in: &cancellables)
    }
    
    private func translateText() {
        guard !detectedText.isEmpty else { return }
        isLoading = true
        
        gptManager.sendMessage(from: detectedText) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    self?.translatedText = self?.gptManager.response ?? ""
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showErrorAlert = true
                }
            }
        }
    }
}
