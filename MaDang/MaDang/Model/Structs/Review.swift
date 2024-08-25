//
//  Review.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//

import Foundation
import FirebaseFirestore

struct Review : Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var performanceId: String
    var performanceTitle: String
    var posterUrl: String
    var writerId: String
    var writerCountry: Country
    var writerName: String
    var createdDate: Date
    var content: String
    var likeCount: Int
    var starRating: Double
    var isReported: Bool
}
