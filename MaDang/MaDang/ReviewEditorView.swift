//
//  ReviewEditorView.swift
//  MaDang
//
//  Created by LDW on 8/19/24.
//

import SwiftUI

struct ReviewEditorView: View {
    @State private var isEditting: Bool = false
    @State private var text: String = ""
    @State private var rating: Double = 0
    var body: some View {
        // NavigationStack { 나중에 연결하며 네비게이션바와 같이 추가
        VStack {
            HStack {
                Image("kopisTestImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width / 4)
                
                VStack {
                    Text("What are your thoughts\non the performance?")
                        .foregroundStyle(.white)
                    
                    
                    // 별점
                    HStack{
                        RatingView($rating, maxRating: 5)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.trailing, 16)
                        Text("\(rating)")
                            .foregroundColor(.white)
                    }
                }
            }
            
            VStack{
                //텍스트 필드
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(.nineDarkGray)
                        .frame(height: UIScreen.main.bounds.height / 2)
                    
                    TextEditor(text: $text)
                        .overlay(alignment: .topLeading) {
                            Text("Tell us your opinion!")
                                .foregroundStyle(text.isEmpty ? .gray : .clear)
                                .font(.title2)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 14)
                        }
                        .scrollContentBackground(.hidden)
                        .foregroundColor(.white)
                        .background(.nineDarkGray)
                        .frame(height: UIScreen.main.bounds.height / 2) // 화면의 절반 높이로 고정
                        .padding(.horizontal, 16)
        
                }
                
                Spacer()
            }
        }
        .background(.nineBlack)
        // }
    }
}

#Preview {
    ReviewEditorView()
}

