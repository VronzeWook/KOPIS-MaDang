//
//  LogoHeader.swift
//  MaDang
//
//  Created by 추서연 on 8/18/24.
//
//
import SwiftUI

struct LogoHeader: View {
    
    @State private var isModalPresented: Bool = false
    @Binding var currentRanking: Ranking
    
    var body: some View {
        
        ZStack{
        VStack{
            HStack{
                Image("logo")
                
                Spacer()
            }.padding(.bottom,5)
            
            HStack{
                Text("Ranking")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Spacer()
                
                Button {
                    withAnimation {
                        isModalPresented.toggle()
                    }
                } label: {
                    HStack{
                        Text("\(currentRanking.rawValue)")
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
            }
            if isModalPresented {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isModalPresented.toggle()
                        }
                    }
                
                    RankingModalView(showModal: $isModalPresented, selectedRanking: $currentRanking)
                    
                
            }
            
        }
        .background(.nineBlack)
        .padding(.horizontal,16)
    }
}

#Preview{
    LogoHeader(currentRanking: .constant(.Likes))
}

