//
//  ApiModel.swift
//  MaDang
//
//  Created by LDW on 8/18/24.
//

import Foundation

// MARK: - Welcome4
struct Welcome4 {
    let dbs: Dbs
}

// MARK: - Dbs
struct Dbs {
    let script: String
    let db: [DB]
}

// MARK: - DB
struct DB {
    var mt20id, prfnm, prfpdfrom, prfpdto: String
    var fcltynm: String
    var poster: String
    var area, genrenm, openrun, prfstate: String
}


struct DetailDB {
    var id: String
    var title: String
    var genre: String
    var startDate: String
    var endDate: String
    var venue: String
    var cast: [String]
    var crew: [String]
    var runtime: String
    var ageLimit: String
    var company: String
    var ticketPrice: String
    var posterUrl: String
    var imageUrls: [String]
    var area: String
    var performanceStatus: String
    var showtimes: String
    var relatedLinks: [DetailDbs]
}

struct DetailDbs {
    var name: String
    var url: String
}

