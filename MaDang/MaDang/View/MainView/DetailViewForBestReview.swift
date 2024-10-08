//import SwiftUI
//
//struct DetailViewForBestReview: View {
//    @EnvironmentObject var userManager: UserManager
//    var review: Review
//    @State private var perform: Performance
//    @State private var isDataLoaded = false
//    @State private var isFavorite = false
//    
//    var body: some View {
//        ScrollView {
//            DetailInfoView(perform: $perform)
//                .padding(.bottom, 96)
//            DetailImageView(perform: $perform)
//            DetailReviewView(perform: $perform, isReportModalPresented: $is
//            // DetailCastingView(numberOfCircles: 7, perform: $perform)
//            DetailTouristInfoView()
//        }
//        .background(.nineBlack)
//        .onAppear {
//            isFavorite = userManager.user!.likePerformIdList.contains(perform.id)
//            loadPerformanceData()
//        }
//        .navigationTitle("\(perform.title)")
//        .toolbar {
//            ToolbarItem(placement: .topBarTrailing) {
//                Button(action: {
//                    isFavorite.toggle()
//                    favoriteButtonTapped(isFavorite, perform: &perform)
//                }, label: {
//                    Image(systemName: isFavorite ? "heart.fill" : "heart")
//                })
//            }
//        }
//    }
//
//    
//    private func loadPerformanceData() {
//        let dispatchGroup = DispatchGroup()
//
//        // KOPIS 데이터를 가져오기
//        dispatchGroup.enter()
//        KopisNetworkingManager.shared.fetchPerform(id: review.performanceId) { result in
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    perform.genre = data.genre
//                    perform.showtime = data.showtime
//                    perform.ageLimit = data.ageLimit
//                    perform.posterUrlList.append(contentsOf: data.posterUrlList)
//                    perform.area = data.area
//
////                    perform.startDate = data.startDate
////                    perform.endDate = data.endDate
//                }
//                isDataLoaded = true
//            case .failure(_):
//                print("KOPIS perform fetch failure")
//            }
//            dispatchGroup.leave()
//        }
//
//        // Firestore에 저장된 perform 받아오기
//        dispatchGroup.enter()
//        FirestoreManager.shared.fetchPerformanceById(performanceId: review.performanceId) { result in
//            switch result {
//            case .success(let fetchedPerform):
//                DispatchQueue.main.async {
//                    self.perform.likeCountCHN = fetchedPerform.likeCountCHN
//                    self.perform.likeCountUSA = fetchedPerform.likeCountUSA
//                    self.perform.likeCountJPN = fetchedPerform.likeCountJPN
//                    self.perform.likeCountKOR = fetchedPerform.likeCountKOR
//                }
//            case .failure(_):
//                // Perform이 없을 경우 생성
//                FirestoreManager.shared.upsertPerformance(performance: perform) { result in
//                    switch result {
//                    case .success():
//                        print("Performance created successfully")
//                    case .failure(_):
//                        print("Failed to create performance")
//                    }
//                }
//            }
//            dispatchGroup.leave()
//        }
//
//        // 모든 비동기 작업이 완료된 후 실행될 코드
//        dispatchGroup.notify(queue: .main) {
//            print("All data loaded or created successfully")
//        }
//    }
//    
//    private func favoriteButtonTapped(_ state: Bool, perform: inout Performance) {
//        guard let country = userManager.user?.country else {
//            print("User's country is not set.")
//            return
//        }
//
//        // Perform 업데이트 함수
//        func updateLikeCount(for countryLikeCount: inout Int) {
//            if state {
//                countryLikeCount += 1
//            } else {
//                if countryLikeCount > 0 {
//                    countryLikeCount -= 1
//                }
//            }
//        }
//
//        // 국가에 따른 likeCount 업데이트
//        switch country {
//        case .USA:
//            updateLikeCount(for: &perform.likeCountUSA)
//        case .JPN:
//            updateLikeCount(for: &perform.likeCountJPN)
//        case .CHN:
//            updateLikeCount(for: &perform.likeCountCHN)
//        case .KOR:
//            updateLikeCount(for: &perform.likeCountKOR)
//        default:
//            print("Unhandled country case.")
//        }
//
//        // Firestore에 업데이트된 Perform 저장
//        FirestoreManager.shared.upsertPerformance(performance: perform) { result in
//            switch result {
//            case .success():
//                print("Performance favorite changed successfully")
//            case .failure(_):
//                print("Failed to change performance favorite")
//            }
//        }
//        
//        // User의 likePerformIdList 업데이트
//        if state {
//            userManager.user?.likePerformIdList.append(perform.id)
//        } else {
//            userManager.user?.likePerformIdList.removeAll { $0 == perform.id }
//        }
//        
//        // Firestore에 업데이트된 User 저장
//        FirestoreManager.shared.updateUser(userManager.user!) { result in
//            switch result {
//            case .success():
//                print("User's likePerformIdList updated successfully")
//            case .failure(let error):
//                print("Failed to update user's likePerformIdList: \(error.localizedDescription)")
//            }
//        }
//    }
//}
