//
//  PopularityRankingView.swift
//  MaDang
//
//  Created by LDW on 8/17/24.
//
import SwiftUI

struct PopularityRankingView: View {
    
    @Binding var selectedTab: Int
    // 랭킹 및 국가로 필터링 된 공연
    @Binding var performs: [Performance]
    @State private var fetchedPerforms: [Performance] = []
    @State private var isLoading = true
    
    @State private var selection = 0
    
    var body: some View {
        VStack{
            HStack{
                Text("Popularity Ranking")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button {
                    selectedTab = 2
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
                    ForEach(fetchedPerforms.indices, id: \.self) { i in
                        VStack {
                            NavigationLink {
                                DetailView(perform: $fetchedPerforms[i])
                            } label: {
                                RankingCell(rank: i + 1, perform: $fetchedPerforms[i])
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
        .background(.nineBlack)
        .onAppear {
            loadPerformances()
        }
        .onChange(of: performs) { _ in
                    loadPerformances()
                }
    }
    
    private var countrySegmentedView: some View {
        ScrollView(.horizontal) {
            HStack {
                Button(action: {
                    selection = 0
                    loadPerformances()  // 선택된 국가에 맞게 다시 로드
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
                    loadPerformances()  // 선택된 국가에 맞게 다시 로드
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
                    loadPerformances()  // 선택된 국가에 맞게 다시 로드
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
                    loadPerformances()  // 선택된 국가에 맞게 다시 로드
                }, label: {
                    Text("🇯🇵 JAN")
                        .font(.system(size: 16))
                        .foregroundStyle(selection == 3 ? .nineBlack : .white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(selection == 3 ? .nineYellow : .nineDarkGray)
                        .cornerRadius(55)
                })
            }
        }
    }
    
    private func loadPerformances() {
        var loadedPerforms: [Performance] = []
        let dispatchGroup = DispatchGroup()

        for perform in performs {
            dispatchGroup.enter()
            FirestoreManager.shared.fetchPerformanceById(performanceId: perform.id) { result in
                switch result {
                case .success(let fetchedPerform):
                    loadedPerforms.append(fetchedPerform)
                case .failure(let error):
                    print("Failed to fetch performance: \(error.localizedDescription)")
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            // 선택된 국가에 따라 정렬
            switch selection {
            case 1: // USA
                self.fetchedPerforms = loadedPerforms.sorted(by: { $0.likeCountUSA > $1.likeCountUSA })
            case 2: // CHN
                self.fetchedPerforms = loadedPerforms.sorted(by: { $0.likeCountCHN > $1.likeCountCHN })
            case 3: // JPN
                self.fetchedPerforms = loadedPerforms.sorted(by: { $0.likeCountJPN > $1.likeCountJPN })
            default: // All
                self.fetchedPerforms = loadedPerforms.sorted(by: { $0.likeCount > $1.likeCount })
            }
            self.isLoading = false
        }
    }
}

#Preview {
    PopularityRankingView(selectedTab: .constant(0), performs: .constant(Performance.performList))
}
