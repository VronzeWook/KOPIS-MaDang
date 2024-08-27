//
//  DetailImageView.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//

import SwiftUI

struct DetailImageView: View {
    @State private var showMoreImages = false
    @Binding var perform: Performance
    
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
//                Image("kopisTestImage")
//                    .resizable()
//                    .scaledToFit()
//                AsyncImage(url: URL(string: perform.posterUrlList[0])) { image in
//                    image
//                        .resizable()
//                        .scaledToFit()
//                        .frame(maxWidth: .infinity)
//                } placeholder: {
//                    Color.gray
//                }
//                
                
                // 두 번째 이미지가 전부 보이게 표시
                ZStack(alignment: .bottom) {
                    AsyncImage(url: URL(string: perform.posterUrlList[0])) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    
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
                        ForEach(perform.posterUrlList.indices, id: \.self) { index in
                            if !(index == 0) && !(index == 1) {
                                AsyncImage(url: URL(string: perform.posterUrlList[index])) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: .infinity)
                                } placeholder: {
                                    Color.gray
                                }
                            }
                        }
                        
                        
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
    DetailImageView(perform: .constant(Performance.performList[0]))
}
