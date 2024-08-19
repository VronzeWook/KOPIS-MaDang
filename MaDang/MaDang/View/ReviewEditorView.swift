//
//  ReviewEditorView.swift
//  MaDang
//
//  Created by LDW on 8/19/24.
//

import SwiftUI

struct ReviewEditorView: View {
    @FocusState private var isFocused: Bool
    @State private var text: String = ""
    @State private var rating: Double = 0
    
    var body: some View {
        // NavigationStack { 나중에 연결하며 네비게이션바와 같이 추가
        
        GeometryReader { geo in
            
            let width = geo.size.width * 0.3
            let height = geo.size.height * 0.1
            
            VStack {
                HStack {
                    Image("kopisTestImage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: width)
                        .clipped()
                        .mask(
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: width, height: width)
                        )
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("What are your thoughts\non the performance?")
                                .font(.system(size: 16))
                                .foregroundStyle(.white)
                                .padding(.leading, 16)
                            
                            Spacer()
                        }
                        // 별점
                        HStack{
                            RatingView($rating, maxRating: 5)
                                .frame(width: 140, height: 24)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.leading, 16)
                            
                            Text(String(format: "%.1f", rating))
                                .frame(width: 50, height: height)
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                                .font(.system(size: 24))
                                .padding(.trailing, 24)
                        }
                    }
                }
                .padding(.bottom, 24)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(.nineDarkGray)
                        .frame(height: UIScreen.main.bounds.height / 2)
//
//                    TextEditor(text: $text)
//                        .padding(.top, 14)
//                        .padding(.leading, 24)
//                        .overlay(alignment: .topLeading) {
//                            Text("Tell us your opinion!")
//                                .foregroundStyle(text.isEmpty ? .gray : .clear)
//                                .font(.title2)
//                                .padding(.horizontal, 20)
//                                .padding(.vertical, 14)
//                        }
//                        .scrollContentBackground(.hidden)
//                        .foregroundColor(.white)
//                        .background(.clear)
                    //                        .frame(height: UIScreen.main.bounds.height / 2)
                    
                    FocusableTextEditor(text: $text, placeholder: "Tell us your opinion!")
                        .padding(.top, 14)
                        .padding(.leading, 24)
                        .frame(height: UIScreen.main.bounds.height / 2)

                    // .frame(height: geo.size.height * 0.5)
                    
                }
                .onTapGesture {
                    isFocused = true
                }
                
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .background(.nineBlack)
            .contentShape(Rectangle())
            .onTapGesture {
                isFocused = false
            }
            // }
        }
    }
}

#Preview {
    ReviewEditorView()
}

