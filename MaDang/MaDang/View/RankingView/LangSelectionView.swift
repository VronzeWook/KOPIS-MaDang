//
//  LangSelectionView.swift
//  MaDang
//
//  Created by 추서연 on 8/18/24.
//

import SwiftUI

struct LangSelectionView: View {
    @State private var selection = 0
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Button(action: {
                    selection = 0
                }, label: {
                    Text("All")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                    
                        .foregroundStyle(selection == 0 ? .nineBlack : .white)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 8)
                        .background(selection == 0 ? .nineYellow : .nineDarkGray)
                        .cornerRadius(22)
                })
                
                Button(action: {
                    selection = 1
                }, label: {
                    Text("🇺🇸 USA")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundStyle(selection == 1 ? .nineBlack : .white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(selection == 1 ? .nineYellow : .nineDarkGray)
                        .cornerRadius(22)
                })
                
                Button(action: {
                    selection = 2
                }, label: {
                    Text("🇨🇳 CHN")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundStyle(selection == 2 ? .nineBlack : .white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(selection == 2 ? .nineYellow : .nineDarkGray)
                        .cornerRadius(22)
                })
                
                Button(action: {
                    selection = 3
                }, label: {
                    Text("🇯🇵 JAN")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundStyle(selection == 3 ? .nineBlack : .white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(selection == 3 ? .nineYellow : .nineDarkGray)
                    .cornerRadius(22)                    })
            }
        }.padding(.horizontal,16)
    }
}

#Preview{
    LangSelectionView()
}
