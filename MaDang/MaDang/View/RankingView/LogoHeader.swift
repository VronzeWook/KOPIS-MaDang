//
//  LogoHeader.swift
//  MaDang
//
//  Created by 추서연 on 8/18/24.
//
//
import SwiftUI

struct LogoHeader: View {
    
    @Binding var isModalPresented: Bool
    @Binding var currentRanking: Ranking
    
    var body: some View {
        
 //       ZStack{
        VStack{
//            HStack{
//                Image("logo")
//                
//                Spacer()
//            }.padding(.bottom,5)
            
            HStack{
                Text("Ranking")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Spacer()
                
//                Button {
//                    withAnimation {
//                        isModalPresented.toggle()
//                    }
//                } label: {
                    HStack{
//                        Text("\(currentRanking.rawValue)")
                         Text("By Likes")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(.nineYellow)
                            .padding(.vertical, 8)
//                        
//                        Image(systemName: "chevron.down")
//                            .foregroundStyle(.nineYellow)
                        
                    }
                    .padding(.horizontal, 18)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18.5)
                            .foregroundStyle(.nineYellow.opacity(0.2))
                    )
//                }
            }
            }
//        .sheet(isPresented: $isModalPresented, content: {
//            RankingModalView(showModal: $isModalPresented, selectedRanking: $currentRanking)
//                .presentationDetents([.fraction(0.3)]) // 모달 높이를 화면의 30%로 설정
//                .presentationDragIndicator(.visible)  // 모달 상단에 드래그 바 표시
//        })
        
        
        //            if isModalPresented {
//                Color.black.opacity(0.4)
//                    .edgesIgnoringSafeArea(.all)
//                    .onTapGesture {
//                        withAnimation {
//                            isModalPresented.toggle()
//                        }
//                    }
//                
//                    RankingModalView(showModal: $isModalPresented, selectedRanking: $currentRanking)
//                    
//                
//            }
            
//        }
        .background(.nineBlack)
        .padding(.horizontal,16)
    }
}

#Preview{
    LogoHeader(isModalPresented: .constant(false), currentRanking: .constant(.Likes))
}

