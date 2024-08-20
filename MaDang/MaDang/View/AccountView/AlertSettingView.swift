//
//  AlertSettingView.swift
//  MaDang
//
//  Created by 추서연 on 8/21/24.
//

import SwiftUI

struct AlertSettingView: View {
    
    @State private var whatsNewToggle: Bool = false
    @State private var likesToggle: Bool = false
    @State private var touristInfoToggle: Bool = false

    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                   
                    
                    VStack{
                        
                        HStack{
                            Text("What’s new")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Toggle("", isOn: $whatsNewToggle)
                                .labelsHidden()
                                .tint(.nineDarkYellow)
                        }
                        Divider()
                            .background(Color.gray)
                            .padding(.vertical,4)
                        
                        HStack{
                            Text("Likes")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Toggle("", isOn: $likesToggle)
                                .labelsHidden()
                                .tint(.nineDarkYellow)
                        }
                        .padding(.vertical,4)
                        Divider()
                            .background(Color.gray)
                            .padding(.vertical,4)
                        
                        HStack{
                            Text("Tourist information")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Toggle("", isOn: $touristInfoToggle)
                                .labelsHidden()
                                .tint(.nineDarkYellow)
                        }
                        
                       
                           
                    }
                    .padding(20)
                    .background(.nineDarkGray)
                    .cornerRadius(15)
                    
                }
                .background(.nineBlack)
                .padding(.horizontal, 16)
            
            }
            .background(.nineBlack)
        }
    }
}

#Preview {
    AlertSettingView()
}
