//
//  AccountView.swift
//  MaDang
//
//  Created by 추서연 on 8/20/24.
//

import SwiftUI

struct AccountView: View {

    var body: some View {
        ZStack {
            ScrollView {
                AccountProfile()
                    .padding(.bottom, 51)
                
                MyActivityList()
                    .padding(.bottom, 51)
                
                CommunityList()
                
                Button {
                   
                } label: {
                    Text("로그아웃")
                }
            }
            .background(.nineBlack)
        }
    }
}

#Preview {
    AccountView()
}
