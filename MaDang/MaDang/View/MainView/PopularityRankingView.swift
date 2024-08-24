//
//  PopularityRankingView.swift
//  MaDang
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct PopularityRankingView: View {
    
    // 랭킹 및 국가로 필터링 된 공연
    @Binding var performs: [Performance]
    @State private var selection = 0
    
    var body: some View {

            VStack{
                HStack{
                    Text("Popularity Ranking")
                        .foregroundStyle(.white)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    NavigationLink {
                        
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle")
                                .foregroundStyle(.nineYellow)
                            Text("More")
                                .font(.system(size: 16))
                                .foregroundStyle(.nineYellow)
                        }
                    }
                }
                
                countrySegmentedView
                    .padding(.bottom, 8)
                
                ScrollView(.horizontal) {
                    HStack{
                        ForEach(performs.indices, id: \.self) { i in
                            VStack {
                                NavigationLink {
                                    DetailView(perform: $performs[i])
                                } label: {
                                    RankingCell(rank: i + 1, perform: $performs[i])
                                        .padding(.horizontal, 6)
                                }
                                
                                Spacer()
                            }
                            .frame(height: 230)
                        }
                    }
                    .padding(.leading, 16)
                }
            }
            //.border(.pink)
            .background(.nineBlack)
        }
    
}

extension PopularityRankingView {
    private var countrySegmentedView: some View {
        ScrollView(.horizontal) {
            HStack {
                Button(action: {
                    selection = 0
                }, label: {
                    Text("All")
                        .font(.system(size: 16))
                        .foregroundStyle(selection == 0 ? .nineBlack : .white)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 8)
                        .background(selection == 0 ? .nineYellow : .nineDarkGray)
                        .cornerRadius(55)
                })
                
                Button(action: {
                    selection = 1
                }, label: {
                    Text("🇺🇸 USA")
                        .font(.system(size: 16))
                        .foregroundStyle(selection == 1 ? .nineBlack : .white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(selection == 1 ? .nineYellow : .nineDarkGray)
                        .cornerRadius(55)
                })
                
                Button(action: {
                    selection = 2
                }, label: {
                    Text("🇨🇳 CHN")
                        .font(.system(size: 16))
                        .foregroundStyle(selection == 2 ? .nineBlack : .white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(selection == 2 ? .nineYellow : .nineDarkGray)
                        .cornerRadius(55)
                })
                
                Button(action: {
                    selection = 3
                }, label: {
                    Text("🇯🇵 JAN")
                        .font(.system(size: 16))
                        .foregroundStyle(selection == 3 ? .nineBlack : .white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(selection == 3 ? .nineYellow : .nineDarkGray)
                    .cornerRadius(55)                    })
            }
        }
    }
}

#Preview {
    PopularityRankingView(performs: .constant(Performance.performList))
}
