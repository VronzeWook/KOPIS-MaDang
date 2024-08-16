//
//  DetailImageView.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//

import SwiftUI

struct DetailImageView: View {
    @State private var showMoreImages = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                HStack {
                    Text("Details")
                        .font(.system(size: 22))
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .padding(.bottom, 16)
                
                // 첫 번째 이미지
                Image("kopisTestImage")
                    .resizable()
                    .scaledToFit()
                
                // 두 번째 이미지가 전부 보이게 표시
                ZStack(alignment: .bottom) {
                    Image("kopisTestImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width)
                    
                    if !showMoreImages {
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, .black.opacity(1.5)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: UIScreen.main.bounds.width * 1.3)
                        .frame(maxWidth: .infinity)
                        .overlay(
                            Button(action: {
                                withAnimation {
                                    showMoreImages.toggle()
                                }
                            }) {
                                HStack {
                                    Text("more")
                                    Image(systemName: "arrow.down")
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(.nineDarkGray)
                                .foregroundStyle(.nineYellow)
                                .cornerRadius(55)
                            }
                            .padding(.bottom, 120),
                            alignment: .bottom
                        )
                    }
                }

                if showMoreImages {
                    VStack(spacing: 0) {
                        Image("kopisTestImage")
                            .resizable()
                            .scaledToFit()
                        
                        Image("kopisTestImage")
                            .resizable()
                            .scaledToFit()
                        
                        
                        Button(action: {
                            withAnimation {
                                showMoreImages.toggle()
                            }
                        }) {
                            HStack {
                                Text("fold")
                                Image(systemName: "arrow.up")
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(.nineDarkGray)
                            .foregroundStyle(.nineYellow)
                            .cornerRadius(55)
                        }
                        .padding(.top, 20)
                        
                    }
                }
                
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 5)
                    .padding(.bottom, 20)
                    .padding(.vertical, 16)
            }
        }
        .background(.nineBlack)
    }
}

#Preview {
    DetailImageView()
}
