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
    
    static var infoList: [TouristInfo] = [
        TouristInfo(region: "InCheon", address: "Bupyeong-gu, Incheon", country: .USA, type: .restaurant, imageUrl: "Incheon_food_1", name: "Bupyeong History Museum", detail: ""),
        TouristInfo(region: "InCheon", address: "Bupyeong-gu, Incheon", country: .USA, type: .restaurant, imageUrl: "Incheon_food_2", name: "Bupyeong History Museum", detail: ""),
        TouristInfo(region: "InCheon", address: "Bupyeong-gu, Incheon", country: .USA, type: .restaurant, imageUrl: "Incheon_food_3", name: "Bupyeong History Museum", detail: ""),
        TouristInfo(region: "InCheon", address: "Bupyeong-gu, Incheon", country: .USA, type: .restaurant, imageUrl: "Incheon_food_4", name: "Bupyeong History Museum", detail: ""),
        
        
        TouristInfo(region: "cafe region", address: "cafe-gu, Incheon", country: .USA, type: .cafe, imageUrl: "Incheon_cafe_1", name: "cafe cafe cafe", detail: ""),
        TouristInfo(region: "cafe region", address: "cafe-gu, Incheon", country: .USA, type: .cafe, imageUrl: "Incheon_cafe_2", name: "cafe cafe cafe", detail: ""),
        TouristInfo(region: "cafe region", address: "cafe-gu, Incheon", country: .USA, type: .cafe, imageUrl: "Incheon_cafe_3", name: "cafe cafe cafe", detail: ""),
        TouristInfo(region: "cafe region", address: "cafe-gu, Incheon", country: .USA, type: .cafe, imageUrl: "Incheon_cafe_4", name: "cafe cafe cafe", detail: ""),
        
        TouristInfo(region: "tourSpot region", address: "tourSpot-gu, tourSpot", country: .USA, type: .touristSpot, imageUrl: "Incheon_place_1", name: "tourSpot tourSpot tourSpot", detail: ""),
        TouristInfo(region: "tourSpot region", address: "tourSpot-gu, tourSpot", country: .USA, type: .touristSpot, imageUrl: "Incheon_place_2", name: "tourSpot tourSpot tourSpot", detail: ""),
        TouristInfo(region: "tourSpot region", address: "tourSpot-gu, tourSpot", country: .USA, type: .touristSpot, imageUrl: "Incheon_place_3", name: "tourSpot tourSpot tourSpot", detail: ""),
        TouristInfo(region: "tourSpot region", address: "tourSpot-gu, tourSpot", country: .USA, type: .touristSpot, imageUrl: "Incheon_place_4", name: "tourSpot tourSpot tourSpot", detail: ""),
    ]
}
