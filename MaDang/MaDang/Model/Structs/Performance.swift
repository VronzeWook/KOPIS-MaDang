//
//  Performance.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//

import Foundation

struct Performance {
    var id: UUID
    var title: String
    var genre: Genre
    var startDate: Date
    var endDate: Date
    var showtime: String
    var ageLimit: String
    var salesVolume: Int
    var posterUrlList: [String]
    var reviewList: [Review]
    var actorList: [Actor]
}
