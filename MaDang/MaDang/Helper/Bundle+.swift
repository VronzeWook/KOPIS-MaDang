//
//  Bundle+.swift
//  MaDang
//
//  Created by LDW on 8/18/24.
//

import Foundation

extension Bundle {
    var apiKey: String? {
        return infoDictionary?["KOPIS_API_KEY"] as? String
    }
}
