//
//  TestTheManagerView.swift
//  MaDang
//
//  Created by 추서연 on 8/23/24.
//

//
//import SwiftUI
//
//struct TestTheManagerView: View {
//    let imageURL: URL
//    @State private var image: UIImage? = nil
//    
//    var body: some View {
//        VStack {
//            AsyncImage(url: imageURL) { asyncImage in
//                if let uiImage = asyncImage.image {
//                    ImageWithOverlayView(image: uiImage)
//                } else {
//                    ProgressView()
//                }
//            }
//            .onAppear {
//                // Load image if necessary
//            }
//        }
//    }
//}
