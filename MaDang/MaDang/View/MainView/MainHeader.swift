//
//  MainHeader.swift
//  MaDang
//
//  Created by 추서연 on 8/23/24.
//

import SwiftUI

struct MainHeader: View {
    @Binding var currentLang: Language
    @Binding var isLangModalPresented: Bool

    var body: some View {
        VStack {
            HStack {
                Image("logo")
                Spacer()
                
                Button {
                    withAnimation {
                        isLangModalPresented.toggle()
                    }
                } label: {
                    HStack {
                        Text("\(currentLang.rawValue)")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(.nineYellow)
                            .padding(.vertical, 8)
                        
                        Image(systemName: "chevron.down")
                            .foregroundStyle(.nineYellow)
                    }
                    .padding(.horizontal, 18)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18.5)
                            .foregroundStyle(.nineYellow.opacity(0.2))
                    )
                }
            }
            .padding(.bottom, 5)

            
        }
        .background(.nineBlack)
        .padding(.horizontal, 16)
    }
}

#Preview {
    MainHeader(currentLang: .constant(.Korean), isLangModalPresented: .constant(false))
}

