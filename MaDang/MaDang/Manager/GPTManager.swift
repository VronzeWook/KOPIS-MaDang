//
//  GPTManager.swift
//  MaDang
//
//  Created by LDW on 8/18/24.
//

import SwiftUI
import ChatGPTSwift

class GPTManager: ObservableObject {
    @Published var response: String = ""
    
    func sendMessage(from text: String, completion: @escaping (Result<Void, Error>) -> Void) {
        self.response = ""
        Task {
            do {
                let api = ChatGPTAPI(apiKey: Bundle.main.object(forInfoDictionaryKey: "API_KEY_GPT") as! String)
                let stream = try await api.sendMessageStream(text: text,
                                                             model: .gpt_hyphen_4,
                                                             systemText: """
                                                            Please translate the following performance data into English and format it according to the provided variables.
                                                            """,
                                                             temperature: 1,
                                                             maxTokens: 550)
                
                for try await line in stream {
                    DispatchQueue.main.async {
                        withAnimation(.smooth(duration: 0.5)) {
                            UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                            self.response += line
                        }
                    }
                }
                DispatchQueue.main.async {
                    completion(.success(()))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}


// 사용 예시
// @StateObject var gptManager = GPTManager()

// gptManager.sendMessage(from: originalText) { result in
//    switch result {
//    case .success:
//        completeTranslate()
//    case .failure(let error):
//        print("오류 발생: \(error.localizedDescription)")
//    }
//}
//
//private func completeTranslate() {
//    print("complete Translate")
//    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
//    isGenerating = false
//    updateUserUsageInfo()
//    withAnimation {
//        rotation = 45
//    }
//}
