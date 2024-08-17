//
//  Review.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//

import Foundation

struct Review {
    var id: UUID
    var performanceId: UUID
    var writerId: UUID
    var writerCountry: Country
    var writerName: String
    var createdDate: Date
    var content: String
    var likeCount: Int
    var starRating: StarRating
    var isReported: Bool
}
