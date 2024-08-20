//
//  User.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//

import Foundation

struct User {
    var id: UUID
    var name: String
    var country: Country
    // var image  백로그
    var reviews: [Review]
    var likeReviewId: [String]
    var favoritePerformanceId: [String]
}

var currentUser = User(
    id: UUID(),
    name: "John",
    country: .USA,
    reviews: [
        Review(id: UUID().uuidString, performanceId: Performance.performList[1].id, writerId: UUID().uuidString, writerCountry: .USA, writerName: "John", createdDate: Date(), content: "Amazing performance! The show was fantastic and the acting was top-notch. Highly recommend it!", likeCount: 25, starRating: 5.0, isReported: false),
            Review(id: UUID().uuidString, performanceId: Performance.performList[0].id, writerId: UUID().uuidString, writerCountry: .USA, writerName: "John", createdDate: Date(), content: "Not bad, but it could be better. Some parts were a bit slow.", likeCount: 10, starRating: 3.5, isReported: false),
            Review(id: UUID().uuidString, performanceId: Performance.performList[1].id, writerId: UUID().uuidString, writerCountry: .USA, writerName: "John", createdDate: Date(), content: "I didn't enjoy it as much as I expected. The plot was predictable.", likeCount: 5, starRating: 2.0, isReported: false)
        ],
    likeReviewId: [],
    favoritePerformanceId: [
        Performance.performList[0].id,
        Performance.performList[2].id,
        Performance.performList[4].id,
        Performance.performList[6].id
    ]
)
