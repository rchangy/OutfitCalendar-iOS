//
//  WearingHistory.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/4/7.
//

import Foundation

struct WearingHistory: Codable {
    var date: Date = Date.now
    var userId: Int64 = 0
    var cloth1: Int64? = nil
    var cloth2: Int64? = nil
    var cloth3: Int64? = nil
    var cloth4: Int64? = nil
    var cloth5: Int64? = nil
    
    private enum CodingKeys: String, CodingKey {
        case date = "Date"
        case userId = "UserId"
        case cloth1 = "Cloth1"
        case cloth2 = "Cloth2"
        case cloth3 = "Cloth3"
        case cloth4 = "Cloth4"
        case cloth5 = "Cloth5"
    }
}
