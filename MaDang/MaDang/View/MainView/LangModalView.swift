//
//  LangModalView.swift
//  MaDang
//
//  Created by 추서연 on 8/23/24.
//

import SwiftUI

struct LangModalView: View {
    @Binding var showModal: Bool
    @Binding var selectedLang: Language
    
    var body: some View {
        
        ZStack{
            Color.nineBlack.opacity(0.2)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                Text("Language")
                    .font(.title3)
                    .foregroundStyle(.nineYellow)
                    .padding(.top, 20)
                    .padding(.bottom, 6)
                Text("Please select the language you want.")
                    .font(.callout)
                    .foregroundStyle(.gray)
                
                ForEach(Language.allCases, id: \.self) { lang in
                    Divider()
                        .background(Color.gray)
                        .padding(.vertical, 16)
                    
                    Button(action: {
                        withAnimation {
                            selectedLang = lang
                            showModal.toggle()
                        }
                    }, label: {
                        VStack {
                            Text("\(lang.rawValue)")
                                .font(.callout)
                                .foregroundStyle(.white)
                        }
                    })
                }
            }
            .padding(.bottom, 16)
            .background(.nineDarkGray)
            .cornerRadius(15)
            .padding(.horizontal, 44)
            .shadow(radius: 20)
        }
    }
}

#Preview {
    LangModalView(showModal: .constant(true), selectedLang: .constant(.Korean))
}
