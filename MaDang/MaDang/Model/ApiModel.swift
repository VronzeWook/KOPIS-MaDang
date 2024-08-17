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
    var mt20ID, prfnm, prfpdfrom, prfpdto: String
    var fcltynm: String
    var poster: String
    var area, genrenm, openrun, prfstate: String
}
