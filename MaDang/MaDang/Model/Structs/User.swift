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
    reviews: [],
    likeReviewId: [],
    favoritePerformanceId: [
        Performance.performList[0].id,
        Performance.performList[2].id,
        Performance.performList[4].id,
        Performance.performList[6].id
    ]
)
