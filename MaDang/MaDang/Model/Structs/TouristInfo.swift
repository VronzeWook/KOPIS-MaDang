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
        TouristInfo(region: "InCheon", address: "Bupyeong-gu, Incheon", country: .USA, type: .restaurant, imageUrl: "kopisTestImage", name: "Bupyeong History Museum", detail: ""),
        TouristInfo(region: "InCheon", address: "Bupyeong-gu, Incheon", country: .USA, type: .restaurant, imageUrl: "kopisTestImage", name: "Bupyeong History Museum", detail: ""),
        TouristInfo(region: "InCheon", address: "Bupyeong-gu, Incheon", country: .USA, type: .restaurant, imageUrl: "kopisTestImage", name: "Bupyeong History Museum", detail: ""),
        TouristInfo(region: "InCheon", address: "Bupyeong-gu, Incheon", country: .USA, type: .restaurant, imageUrl: "kopisTestImage", name: "Bupyeong History Museum", detail: ""),
        TouristInfo(region: "InCheon", address: "Bupyeong-gu, Incheon", country: .USA, type: .restaurant, imageUrl: "kopisTestImage", name: "Bupyeong History Museum", detail: ""),
        TouristInfo(region: "InCheon", address: "Bupyeong-gu, Incheon", country: .USA, type: .restaurant, imageUrl: "kopisTestImage", name: "Bupyeong History Museum", detail: ""),
        TouristInfo(region: "InCheon", address: "Bupyeong-gu, Incheon", country: .USA, type: .restaurant, imageUrl: "kopisTestImage", name: "Bupyeong History Museum", detail: ""),
        
        TouristInfo(region: "cafe region", address: "cafe-gu, Incheon", country: .USA, type: .cafe, imageUrl: "kopisTestImage", name: "cafe cafe cafe", detail: ""),
        TouristInfo(region: "cafe region", address: "cafe-gu, Incheon", country: .USA, type: .cafe, imageUrl: "kopisTestImage", name: "cafe cafe cafe", detail: ""),
        TouristInfo(region: "cafe region", address: "cafe-gu, Incheon", country: .USA, type: .cafe, imageUrl: "kopisTestImage", name: "cafe cafe cafe", detail: ""),
        TouristInfo(region: "cafe region", address: "cafe-gu, Incheon", country: .USA, type: .cafe, imageUrl: "kopisTestImage", name: "cafe cafe cafe", detail: ""),
        TouristInfo(region: "cafe region", address: "cafe-gu, Incheon", country: .USA, type: .cafe, imageUrl: "kopisTestImage", name: "cafe cafe cafe", detail: ""),
        TouristInfo(region: "cafe region", address: "cafe-gu, Incheon", country: .USA, type: .cafe, imageUrl: "kopisTestImage", name: "cafe cafe cafe", detail: ""),
        TouristInfo(region: "cafe region", address: "cafe-gu, Incheon", country: .USA, type: .cafe, imageUrl: "kopisTestImage", name: "cafe cafe cafe", detail: ""),
        
        TouristInfo(region: "tourSpot region", address: "tourSpot-gu, tourSpot", country: .USA, type: .touristSpot, imageUrl: "kopisTestImage", name: "tourSpot tourSpot tourSpot", detail: ""),
        TouristInfo(region: "tourSpot region", address: "tourSpot-gu, tourSpot", country: .USA, type: .touristSpot, imageUrl: "kopisTestImage", name: "tourSpot tourSpot tourSpot", detail: ""),
        TouristInfo(region: "tourSpot region", address: "tourSpot-gu, tourSpot", country: .USA, type: .touristSpot, imageUrl: "kopisTestImage", name: "tourSpot tourSpot tourSpot", detail: ""),
        TouristInfo(region: "tourSpot region", address: "tourSpot-gu, tourSpot", country: .USA, type: .touristSpot, imageUrl: "kopisTestImage", name: "tourSpot tourSpot tourSpot", detail: ""),
        TouristInfo(region: "tourSpot region", address: "tourSpot-gu, tourSpot", country: .USA, type: .touristSpot, imageUrl: "kopisTestImage", name: "tourSpot tourSpot tourSpot", detail: ""),
        TouristInfo(region: "tourSpot region", address: "tourSpot-gu, tourSpot", country: .USA, type: .touristSpot, imageUrl: "kopisTestImage", name: "tourSpot tourSpot tourSpot", detail: ""),
        TouristInfo(region: "tourSpot region", address: "tourSpot-gu, tourSpot", country: .USA, type: .touristSpot, imageUrl: "kopisTestImage", name: "tourSpot tourSpot tourSpot", detail: ""),
    ]
}
