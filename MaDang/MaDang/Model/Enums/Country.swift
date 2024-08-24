//
//  Country.swift
//  MaDang
//
//  Created by LDW on 8/17/24.
//

import Foundation

enum Country: String, Codable, CaseIterable, Hashable {
    case USA
    case JPN
    case CHN
    case KOR
    case ALL
    
    var flag: String {
        switch self {
        case .KOR:
            return "🇰🇷"
        case .USA:
            return "🇺🇸"
        case .CHN:
            return "🇨🇳"
        case .JPN:
            return "🇯🇵"
        case .ALL:
            return "🏳️"
        }
    }
}
