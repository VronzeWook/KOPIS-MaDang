//
//  LikesView.swift
//  MaDang
//
//  Created by 추서연 on 8/20/24.
//

import SwiftUI

struct LikesView: View {
    @State private var favoritePerformanceIds: Set<String>
    let user: User
    
    // 초기화 시, 사용자 즐겨찾기 ID를 상태로 설정
    init(user: User) {
        self.user = user
        _favoritePerformanceIds = State(initialValue: Set(user.favoritePerformanceId))
    }
    
    // 사용자의 favoritePerformanceId와 일치하는 공연 필터링
    var favoritePerformances: [Performance] {
        Performance.performList.filter { performance in
            favoritePerformanceIds.contains(performance.id)
        }
    }
    
    // Date를 원하는 형식으로 변환하는 메서드
    func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
    
    // 하트 아이콘 상태를 변경하는 메서드
    private func toggleFavorite(for performanceId: String) {
        withAnimation(.easeInOut) {
            if favoritePerformanceIds.contains(performanceId) {
                favoritePerformanceIds.remove(performanceId)
            } else {
                favoritePerformanceIds.insert(performanceId)
            }
        }
    }
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let imageWidth = (screenWidth - 45) * 0.5
        let aspectRatio: CGFloat = 240 / 173
        
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                ForEach(favoritePerformances, id: \.id) { performance in
                    VStack(alignment: .leading) {
                        
                        ZStack(alignment: .bottomTrailing) {
                            if let url = performance.posterUrlList.first, let imageUrl = URL(string: url) {
                                AsyncImage(url: imageUrl) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .frame(width: imageWidth, height: imageWidth * aspectRatio)
                                            .overlay(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.7)]),
                                                    startPoint: .center,
                                                    endPoint: .bottom
                                                )
                                            )
                                    default:
                                        Image("profile")
                                            .resizable()
                                            .frame(width: imageWidth, height: imageWidth * aspectRatio)
                                            .overlay(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.7)]),
                                                    startPoint: .center,
                                                    endPoint: .bottom
                                                )
                                            )
                                    }
                                }
                            } else {
                                Image("profile")
                                    .resizable()
                                    .frame(width: imageWidth, height: imageWidth * aspectRatio)
                                    .overlay(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.7)]),
                                            startPoint: .center,
                                            endPoint: .bottom
                                        )
                                    )
                            }
                            
                            
                            Button(action: {
                                toggleFavorite(for: performance.id)
                            }) {
                                Image(systemName: favoritePerformanceIds.contains(performance.id) ? "heart.fill" : "heart")
                                    .font(.system(size: 20))
                                    .foregroundColor(favoritePerformanceIds.contains(performance.id) ? .nineYellow : .white)
                                    .padding(5)
                                    .scaleEffect(favoritePerformanceIds.contains(performance.id) ? 1.2 : 1.0)
                            }
                            .padding(10)
                        }
                        
                        Text(performance.title)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: imageWidth)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .padding(.bottom, 6)
                        
                        HStack {
                            Image(systemName: "calendar")
                                .font(.system(size: 12))
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            
                            Text(formattedDate(performance.startDate))
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            
                            Text("~")
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            
                        }
                        
                        HStack {
                            Image(systemName: "calendar")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                            
                            Text(formattedDate(performance.endDate))
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            
                        }
                        .padding(.bottom, 1)
                        
                        HStack {
                            Image(systemName: "shoeprints.fill")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .foregroundStyle(.gray)
                            
                            Text(performance.area)
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .foregroundStyle(.gray)
                        }
                    }
                    .frame(width: imageWidth)
                    .padding(.bottom, 35)
                }
            }
            .padding(.horizontal)
        }
        .background(Color.black)
        
        
    }
}

#Preview {
    LikesView(user: currentUser)
}
