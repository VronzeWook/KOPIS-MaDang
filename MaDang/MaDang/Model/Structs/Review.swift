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
    var posterUrl: String
    var writerId: String
    var writerCountry: Country
    var writerName: String
    var createdDate: Date
    var content: String
    var likeCount: Int
    var starRating: Double
    var isReported: Bool

//    static var reviews: [Review] = [Review(id: UUID(), performanceId: Performance.performList[0].id, writerId: UUID(), writerCountry: .USA, writerName: "joy", createdDate: Date(), content: "abcdefghijklmn op abcdef g hijk lmnop abc defg hijklmnop abcdefgh ijkl mnop  abcdefgh ijklmnop abcdefghijklmnop efghijklmnop abcdefghijklmnop abcdefghijklmnop abcdefghijklmnop abcdefghijklmnop abcdefghi", likeCount: 123, starRating: 4.5, isReported: false),
//                                    Review(id: UUID(), performanceId: Performance.performList[1].id, writerId: UUID(), writerCountry: .USA, writerName: "joy", createdDate: Date(), content: "abcdefghijklmn op abcdef g hijk lmnop abc defg hijklmnop abcdefgh ijkl mnop  abcdefgh ijklmnop abcdefghijklmnop efghijklmnop abcdefghijklmnop abcdefghijklmnop abcdefghijklmnop abcdefghijklmnop abcdefghi", likeCount: 123, starRating: 4.5, isReported: false),
//                                    Review(id: UUID(), performanceId: Performance.performList[2].id, writerId: UUID(), writerCountry: .USA, writerName: "joy", createdDate: Date(), content: "abcdefghijklmn op abcdef g hijk lmnop abc defg hijklmnop abcdefgh ijkl mnop  abcdefgh ijklmnop abcdefghijklmnop efghijklmnop abcdefghijklmnop abcdefghijklmnop abcdefghijklmnop abcdefghijklmnop abcdefghi", likeCount: 123, starRating: 4.5, isReported: false),
//                                    Review(id: UUID(), performanceId: Performance.performList[0].id, writerId: UUID(), writerCountry: .USA, writerName: "joy", createdDate: Date(), content: "abcdefghijklmn op abcdef g hijk lmnop abc defg hijklmnop abcdefgh ijkl mnop  abcdefgh ijklmnop abcdefghijklmnop efghijklmnop abcdefghijklmnop abcdefghijklmnop abcdefghijklmnop abcdefghijklmnop abcdefghi", likeCount: 123, starRating: 4.5, isReported: false)
//
//    ]
}
