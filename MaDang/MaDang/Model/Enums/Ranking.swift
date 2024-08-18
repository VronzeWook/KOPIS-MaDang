//
//  Ranking.swift
//  MaDang
//
//  Created by 추서연 on 8/18/24.
//

import Foundation

enum Ranking: String, Codable, CaseIterable {
    case Likes = "Likes"
    case Rating = "Rating"
    case TicketSales = "Ticket Sales"
    
    var code: String {
        switch self {
        case .Likes:
            return "likes"
        case .Rating:
            return "rating"
        case .TicketSales:
            return "ticket sales"
        default :
            return "likes"
        }
    }
}
