//
//  DetailView.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var perform: Performance
    @State private var reviews: [Review] = []
    @State private var isDataLoaded = false
    
    var body: some View {
        ScrollView {
            DetailInfoView(perform: $perform)
                .padding(.bottom, 96)
            DetailImageView(perform: $perform)
            DetailReviewView(reviews: $reviews, perform: $perform)
            DetailCastingView(numberOfCircles: 7, perform: $perform)
            DetailTouristInfoView()
        }
        .background(.nineBlack)
        // init에서 필요한 정보 추가 요청
        .onAppear{
            // self._perform = perform // @Binding 값을 초기화
            KopisNetworkingManager.shared.fetchPerform(id: perform.id) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        perform.genre = data.genre
                        perform.showtime = data.showtime
                        perform.ageLimit = data.ageLimit
                        perform.posterUrlList.append(contentsOf: data.posterUrlList)
                    }
                    isDataLoaded = true
                case .failure(_):
                    print("KOPIS perform fetch failure")
                }
                
                // 공연 아이디로 리뷰데이터 호출
                FirestoreManager.shared.fetchReviewsByPerformance(performanceId: perform.id) { result in
                    switch result {
                    case .success(let reviews):
                        self.reviews = reviews
                    case .failure(_):
                        print("Firestore reviews by perform failure")
                    }
                }
            }
        }
    }
}

#Preview {
    DetailView(perform: .constant(Performance.performList[0]))
}
