//
//  Date+.swift
//  MaDang
//
//  Created by LDW on 8/27/24.
//

import Foundation

extension Date {
    func toFormattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
