//
//  ImageWithOverlayView.swift
//  MaDang
//
//  Created by 추서연 on 8/23/24.
//

import SwiftUI

struct ImageWithOverlayView: View {
    let image: UIImage
    @StateObject private var manager = TextAndTranslateManager()

    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .overlay {
                    VStack(alignment: .leading) {
                        if !manager.detectedText.isEmpty {
                            Text(manager.detectedText)
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(5)
                                .background(Color.black.opacity(0.7))
                                .cornerRadius(5)
                                .padding([.top, .leading], 10)
                        }
                        
                        if !manager.translatedText.isEmpty {
                            Text(manager.translatedText)
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
                    manager.processImage(image)
                }
            
            if manager.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
            }
        }
        .alert(isPresented: $manager.showErrorAlert) {
            Alert(title: Text("Error"), message: Text(manager.errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}
