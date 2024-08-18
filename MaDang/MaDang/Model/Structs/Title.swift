//
//  Title.swift
//  MaDang
//
//  Created by 추서연 on 8/18/24.
//

import Foundation

enum Title {
    case main
    case genre
    case ranking
    case account
    
    var name: String {
        switch self {
        case .main:
            return "Main news"
        case .genre:
            return "By genre"
        case .ranking:
            return "Ranking"
        case .account:
            return "Account"
        }
    }
}
