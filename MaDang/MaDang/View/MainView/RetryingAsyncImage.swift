//
//  RetryingAsyncImage.swift
//  MaDang
//
//  Created by LDW on 8/24/24.
//

import SwiftUI

struct ReloadableImageView: View {
    @State private var id = UUID()
    @State private var isLoadingFailed = false
    let url: String
    
    var body: some View {
        VStack {
            // AsyncImage로 이미지를 로드
            AsyncImage(url: URL(string: url)) { phase in
                switch phase {
                case .empty:
                    // 로딩 중
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .nineYellow))
                        .scaleEffect(2)
                case .success(let image):
                    // 이미지 로드 성공
                    image
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(contentMode: .fit)
                        .id(id)
                        .onAppear{
                            isLoadingFailed = false
                        }
                    // 이미지 로드 성공 시 실패 상태 초기화
                   
                case .failure:
                    // 이미지 로드 실패
                    VStack {
                        Text("Tap to see!")
                            .foregroundColor(.nineYellow)
                            .onAppear{
                                id = UUID() // UUID를 갱신하여 다시 로드 시도
                                isLoadingFailed = true
                            }
                    }
                @unknown default:
                    // 기본 처리
                    EmptyView()
                }
            }
            .onAppear {
                // 뷰가 나타날 때 로딩 상태 초기화
                isLoadingFailed = false
            }
            .frame(width: 200, height: 300)
        }
    }
}
