//
//  RankingView.swift
//  MaDang
//
//  Created by 추서연 on 8/18/24.
//

import SwiftUI

//struct RankingView: View {
//    @State private var currentRanking: Ranking = .Likes
//    @State private var isModalPresented: Bool = false
//    @Binding var performs: [Performance]
//    
//    var body: some View {
//        ZStack {
//            ScrollView {
//                LogoHeader(isModalPresented: $isModalPresented, currentRanking: $currentRanking)
//                LangSelectionView()
//                RankingListView(performs: $performs)
//            }
//            
//            if isModalPresented {
//                Color.black.opacity(0.4)
//                    .edgesIgnoringSafeArea(.all)
//                    .onTapGesture {
//                        withAnimation {
//                            isModalPresented.toggle()
//                        }
//                    }
//                
//                RankingModalView(showModal: $isModalPresented, selectedRanking: $currentRanking)
//            }
//        }
//        .background(.nineBlack)
//    }
//}
//
//#Preview {
//    RankingView(performs: .constant(Performance.performList))
//}

struct RankingView: View {
    @State private var currentRanking: Ranking = .Likes
    @State private var isModalPresented: Bool = false
    @State private var selection: Int = 0
    @State private var fetchedPerforms: [Performance] = []
    @State private var isLoading = true
    @Binding var performs: [Performance]
    
    var body: some View {
        ZStack {
//            if isLoading {
//                ProgressView("Loading...")
//                    .foregroundStyle(.nineYellow)
//                    .padding(.top, 50)
//                    .background(.nineBlack)
//                    .ignoresSafeArea(.all)
//            } else {
                ScrollView {
                    LogoHeader(isModalPresented: $isModalPresented, currentRanking: $currentRanking)
                    LangSelectionView(selection: $selection)
                    RankingListView(performs: $fetchedPerforms, selection: $selection)
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
//        }
        .onAppear {
            loadPerformances()
        }
        .background(.nineBlack)
        .onChange(of: selection) { _ in
                    sortPerformances()
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
            self.fetchedPerforms = loadedPerforms
            self.sortPerformances() // Initial sort based on the selection
            self.isLoading = false
        }
    }
 
    private func sortPerformances() {
        switch selection {
        case 0:
            // All: 기본 likeCount로 정렬
            fetchedPerforms.sort { $0.likeCount > $1.likeCount }
        case 1:
            // USA: 미국 좋아요 수 기준으로 정렬
            fetchedPerforms.sort { $0.likeCountUSA > $1.likeCountUSA }
        case 2:
            // CHN: 중국 좋아요 수 기준으로 정렬
            fetchedPerforms.sort { $0.likeCountCHN > $1.likeCountCHN }
        case 3:
            // JPN: 일본 좋아요 수 기준으로 정렬
            fetchedPerforms.sort { $0.likeCountJPN > $1.likeCountJPN }
        default:
            break
        }
    }
    
}
