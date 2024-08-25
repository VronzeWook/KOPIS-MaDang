//
//  Performance.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//

import Foundation

struct Performance: Identifiable, Codable, Hashable  {
    var id: String
    var title: String
    var genre: Genre
    var startDate: Date
    var endDate: Date
    var showtime: String
    var ageLimit: String
    var salesVolume: Int
    var area: String = ""
    var posterUrlList: [String]
//    var reviewList: [Review]
    var actorList: [String]     // 일단 스트링
    var likeCountUSA: Int = 0
    var likeCountCHN: Int = 0
    var likeCountJPN: Int = 0
    var likeCountKOR: Int = 0
    var starRating: Double
    
    var likeCount: Int {
        return likeCountUSA + likeCountCHN + likeCountJPN + likeCountKOR
    }
    
    
    static var performList: [Performance] =  [Performance(id: UUID().uuidString, title: "the Sth a35135135sdg", genre: .Musical, startDate: Date(), endDate: Date(), showtime: "오늘부터 내일까지", ageLimit: "6세 이상", salesVolume: 1253, area:"@@ performance center",posterUrlList: [], actorList: [], likeCountUSA: 123, starRating: 4.53),
                                              Performance(id: UUID().uuidString, title: "the 4555 2", genre: .Musical, startDate: Date(), endDate: Date(), showtime: "오늘", ageLimit: "135세 이상", salesVolume: 1253, posterUrlList: [], actorList: [],likeCountUSA: 123, starRating: 4.5),
                                              Performance(id: UUID().uuidString, title: "t124h asd5ggg", genre: .Musical, startDate: Date(), endDate: Date(), showtime: "오늘부터 12", ageLimit: "6세 이상", salesVolume: 1253, posterUrlList: [], actorList: [],likeCountUSA: 123, starRating: 4.5),
                                              Performance(id: UUID().uuidString, title: "t11555th asdggg", genre: .Musical, startDate: Date(), endDate: Date(), showtime: "내일까지", ageLimit: "6세 이상", salesVolume: 1253, posterUrlList: [], actorList: [],likeCountUSA: 123, starRating: 4.5)
                                              ,
                                              Performance(id: UUID().uuidString, title: "the 4555 2", genre: .Musical, startDate: Date(), endDate: Date(), showtime: "오늘", ageLimit: "135세 이상", salesVolume: 1253, posterUrlList: [], actorList: [],likeCountUSA: 123, starRating: 4.5),
                                              Performance(id: UUID().uuidString, title: "the 4555 2", genre: .Musical, startDate: Date(), endDate: Date(), showtime: "오늘", ageLimit: "135세 이상", salesVolume: 1253, posterUrlList: [], actorList: [],likeCountUSA: 123, starRating: 4.5)
                                              ,
                                              Performance(id: UUID().uuidString, title: "t11555th asdggg", genre: .Musical, startDate: Date(), endDate: Date(), showtime: "내일까지", ageLimit: "6세 이상", salesVolume: 1253, posterUrlList: [], actorList: [],likeCountUSA: 123, starRating: 4.5)
                                              ,
                                              Performance(id: UUID().uuidString, title: "the 4555 2", genre: .Musical, startDate: Date(), endDate: Date(), showtime: "오늘", ageLimit: "135세 이상", salesVolume: 1253, posterUrlList: [], actorList: [],likeCountUSA: 123, starRating: 4.5),
                                              Performance(id: UUID().uuidString, title: "the 4555 2", genre: .Musical, startDate: Date(), endDate: Date(), showtime: "오늘", ageLimit: "135세 이상", salesVolume: 1253, posterUrlList: [], actorList: [],likeCountUSA: 123, starRating: 4.5)
    ]
}
