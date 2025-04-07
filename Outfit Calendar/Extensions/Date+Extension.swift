//
//  Date+Extension.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/4/7.
//

import Foundation

extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
}
