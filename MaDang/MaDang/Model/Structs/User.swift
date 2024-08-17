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
