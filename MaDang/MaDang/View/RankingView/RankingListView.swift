//
//  RankingListView.swift
//  MaDang
//
//  Created by 추서연 on 8/18/24.
//

import SwiftUI

struct RankingListView: View {
    let performs: [Performance]
    
    var body: some View {
        ScrollView{
            VStack{
                
                ForEach(performs.indices, id: \.self){ i in
                    VStack {
                        
                        RankingListCell(title: performs[i].title ,rank: i + 1, imageUrl: "",likeCount: performs[i].likeCount, startRating: performs[i].starRating, genre: performs[i].genre)
                                .padding(.horizontal, 16)
                        
                    }
                    .frame(height: 180)
                }
                
            }
            .padding(.top,16)
            .background(.nineBlack)
        }
    }
}

#Preview {
    RankingListView(performs: Performance.performList)
}
