//
//  TranslateViewModel.swift
//  MaDang
//
//  Created by 추서연 on 8/23/24.
//
import Foundation
import Combine
import UIKit

class TranslateViewModel: ObservableObject {
    @Published var translatedText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    func translate(text: String) {
        // Simulate a network call for translation
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let translated = "Translated: \(text)"  // Simulate translation response
            DispatchQueue.main.async {
                self.translatedText = translated
            }
        }
    }
    
    
    
}

import Foundation

// Simulated translation function
func translate(text: String, completion: @escaping (String) -> Void) {
    // Replace this with an actual API request
    DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
        let translatedText = "Translated: \(text)"  // Simulate a translation result
        DispatchQueue.main.async {
            completion(translatedText)
        }
    }
}
