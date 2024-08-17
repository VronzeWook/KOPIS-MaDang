//
//  TouristInfo.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//

import Foundation

struct TouristInfo {
    var region: String
    var address: String
    var country: Country // enum 재정의
    var type: AttractionType // enum 재정의
    var imageUrl: String
    var name: String
    var detail: String
}
