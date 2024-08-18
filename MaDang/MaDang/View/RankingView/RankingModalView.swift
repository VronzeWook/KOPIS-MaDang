//
//  RankingModalView.swift
//  MaDang
//
//  Created by 추서연 on 8/18/24.
//

import SwiftUI

struct RankingModalView: View {
    @Binding var showModal: Bool
    @Binding var selectedRanking: Ranking
    var body: some View {
        
            VStack(spacing: 0) {
                Text("Ranking")
                    .font(.title3)
                    .foregroundStyle(.nineYellow)
                    .padding(.top,20)
                    .padding(.bottom,6)
                Text("Rankings are provided based on")
                    .font(.callout)
                    .foregroundStyle(.gray)
                Text("the user's selection.")
                    .font(.callout)
                    .foregroundStyle(.gray)
                
                
                ForEach(Ranking.allCases, id: \.self) { ranking in
                    Divider()
                        .background(Color.gray)
                        .padding(.vertical,16)

                    Button(action: {
                        withAnimation {
                            selectedRanking = ranking
                            showModal.toggle()
                        }
                    }, label: {
                        VStack{
                            Text("\(ranking.rawValue)")
                                .font(.callout)
                                .foregroundStyle(.white)
                        }
                    })
                    
                }
            }.padding(.bottom, 16)
            .background(.nineDarkGray)
                .cornerRadius(15)
                .padding(.horizontal,44)
    }
}



#Preview {
    RankingModalView(showModal: .constant(true), selectedRanking: .constant(.Likes))
}
