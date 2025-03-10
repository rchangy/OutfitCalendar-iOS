//
//  URLRequestConvertible.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/2/25.
//

import Foundation

protocol URLRequestConvertible {
    func makeURLRequest() throws -> URLRequest
}
