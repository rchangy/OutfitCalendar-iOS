//
//  NetworkError.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/2/25.
//

enum NetworkError: Error {
    case invalidURL
    case requestFailed(statusCode: Int)
    case invalidResponse
    case dataConversionFailure
}
