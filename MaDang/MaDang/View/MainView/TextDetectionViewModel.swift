//
//  TextDetectionViewModel.swift
//  MaDang
//
//  Created by 추서연 on 8/23/24.
//
//
//import Combine
//import Foundation
//import UIKit
//import Vision
//
//class TextDetectionViewModel: ObservableObject {
//    @Published var detectedText: String = ""
//    @Published var translatedText: String = ""
//    
//    private var gptManager = GPTManager()
//    
//    func processImage(_ image: UIImage) {
//        detectTextTest(in: image) { [weak self] text in
//            DispatchQueue.main.async {
//                self?.detectedText = text
//                if !text.isEmpty {
//                    // Translate the detected text
//                    self?.gptManager.translateText(from: text) { translated in
//                        self?.translatedText = translated
//                    }
//                }
//            }
//        }
//    }
//    
//    private func detectTextTest(in image: UIImage, completion: @escaping (String) -> Void) {
//        guard let cgImage = image.cgImage else {
//            completion("")
//            return
//        }
//        
//        let request = VNRecognizeTextRequest { request, error in
//            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
//                completion("")
//                return
//            }
//            
//            let detectedText = observations.compactMap { observation in
//                observation.topCandidates(1).first?.string
//            }.joined(separator: " ")
//            
//            completion(detectedText)
//        }
//        
//        // Specify language if necessary (optional for Vision framework)
//        request.recognitionLanguages = ["ko-KR"]  // This sets the language to Korean
//        
//        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
//        try? requestHandler.perform([request])
//    }
//}

import Combine
import Foundation
import UIKit
import Vision

class TextDetectionViewModel: ObservableObject {
    @Published var detectedText: String = ""
    @Published var translatedText: String = ""

    private let apiKey = "API_KEY_GPT" 
    
    func processImage(_ image: UIImage) {
        detectText(in: image) { [weak self] text in
            DispatchQueue.main.async {
                self?.detectedText = text
                if !text.isEmpty {
                    // Translate the detected text
                    self?.translateText(text) { translated in
                        self?.translatedText = translated
                    }
                }
            }
        }
    }

    private func detectText(in image: UIImage, completion: @escaping (String) -> Void) {
        guard let cgImage = image.cgImage else {
            completion("")
            return
        }

        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                completion("")
                return
            }

            let detectedText = observations.compactMap { observation in
                observation.topCandidates(1).first?.string
            }.joined(separator: " ")

            completion(detectedText)
        }

        request.recognitionLanguages = ["ko-KR"]  // Sets the language to Korean

        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        try? requestHandler.perform([request])
    }

//    private func translateText(_ text: String, completion: @escaping (String) -> Void) {
//        let url = URL(string: "https://api.openai.com/v1/engines/davinci-codex/completions")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        //request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let body: [String: Any] = [
//            "prompt": "Translate the following Korean text to English:\n\n\(text)",
//            "max_tokens": 60
//        ]
//        
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                completion("Error: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            
//            if let response = try? JSONDecoder().decode(GPTResponse.self, from: data),
//               let translatedText = response.choices.first?.text.trimmingCharacters(in: .whitespacesAndNewlines) {
//                completion(translatedText)
//            } else {
//                completion("Error: Unable to parse response")
//            }
//        }
//        
//        task.resume()
//    }
    
    private func translateText(_ text: String, completion: @escaping (String) -> Void) {
        // Use the correct endpoint for GPT-3.5 or GPT-4
        let url = URL(string: "https://api.openai.com/v1/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer API_KEY_GPT" , forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": "text-davinci-003", // Or "gpt-3.5-turbo", "gpt-4" based on the model you choose
            "prompt": "Translate the following Korean text to English:\n\n\(text)",
            "max_tokens": 60
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(GPTResponse.self, from: data)
                let translatedText = response.choices.first?.text.trimmingCharacters(in: .whitespacesAndNewlines) ?? "No translation available"
                completion(translatedText)
            } catch {
                completion("Error: Unable to parse response")
            }
        }
        
        task.resume()
    }

}

struct GPTResponse: Decodable {
    struct Choice: Decodable {
        let text: String
    }
    let choices: [Choice]
}
