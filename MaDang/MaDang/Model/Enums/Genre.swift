//
//  Genre.swift
//  MaDang
//
//  Created by LDW on 8/16/24.
//

import Foundation

enum Genre: String, Codable, CaseIterable {
    case All
    case Theater = "연극"
    case Musical = "뮤지컬"
    case Classic = "서양음악(클래식)"
    case KoreanTraditionalMusic = "한국음악(국악)"
    case PopularMusic = "대중음악"
    case KoreanTraditionalDancing = "무용(서양/한국무용)"
    case PublicDance = "대중무용"
    case CircusMagic = "서커스/마술"
    
//    case Theater
//    case Musical
//    case Classic
//    case KoreanTraditionalMusic
//    case PopularMusic
//    case KoreanTraditionalDancing
//    case PublicDance
//    case CircusMagic
//    case All
//    case Theater = "Theater"
//    case Musical = "Musical"
//    case Classic = "Classic"
//    case KoreanTraditionalMusic = "KoreanTraditionalMusic"
//    case PopularMusic = "PopularMusic"
//    case KoreanTraditionalDancing = "KoreanTraditionalDancing"
//    case PublicDance = "PublicDance"
//    case CircusMagic = "CircusMagic"
    
    var code: String {
        switch self {
        case .Theater:
            return "AAAA"
        case .Musical:
            return "GGGA"
        case .Classic:
            return "CCCA"
        case .KoreanTraditionalMusic:
            return "CCCC"
        case .PopularMusic:
            return "CCCD"
        case .KoreanTraditionalDancing:
            return "BBBC"
        case .PublicDance:
            return "BBBE"
        case .CircusMagic:
            return "EEEB"
        default :
            return "All"
        }
    }
}
