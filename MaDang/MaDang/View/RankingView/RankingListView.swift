//
//  RankingListView.swift
//  MaDang
//
//  Created by 추서연 on 8/18/24.
//


import SwiftUI

struct RankingListView: View {
    @Binding var performs: [Performance]
    @State private var fetchedPerforms: [Performance] = []
    @State private var isLoading = true

    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView("Loading...")
                    .foregroundStyle(.white)
                    .padding(.top, 50)
            } else {
                VStack {
                    ForEach(fetchedPerforms.indices, id: \.self) { i in
                        VStack {
                            RankingListCell(rank: i + 1, perform: fetchedPerforms[i])
                                .padding(.horizontal, 16)
                        }
                        .frame(height: 180)
                    }
                }
                .padding(.top, 16)
                .background(.nineBlack)
            }
        }
        .onAppear {
            loadPerformances()
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
            // likeCount를 기준으로 정렬
            self.fetchedPerforms = loadedPerforms.sorted(by: { $0.likeCount > $1.likeCount })
            self.isLoading = false
        }
    }
}

#Preview {
    RankingListView(performs: .constant(Performance.performList))
}
