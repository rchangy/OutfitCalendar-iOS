//
//  Router.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/2/23.
//

import Foundation

enum ClothesRouter: URLRequestConvertible {
    case fetchClothes(userId: UInt64)
    case createClothes(clothes: Clothes)
    case updateClothes(clothes: Clothes)
    case removeClothes(clothes: Clothes)
    
    var endpoint: String {
        switch self {
        case .fetchClothes(let userId):
            return "/clothes?UserId=\(userId)"
        case .createClothes:
            return "/clothes/"
        case .updateClothes(let clothes), .removeClothes(let clothes):
            return "/clothes/\(clothes.clothId)"
        }
    }
    
    var method: String {
        switch self {
        case .fetchClothes:
            return "GET"
        case .createClothes:
            return "POST"
        case .updateClothes:
            return "PUT"
        case .removeClothes:
            return "DELETE"
        }
    }
    
    func makeURLRequest() throws -> URLRequest {
        guard let url = URL(string: APIConfig.baseURL! + endpoint) else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        let encoder = JSONEncoder()
        switch self {
        case .createClothes(let clothes), .updateClothes(let clothes), .removeClothes(let clothes):
            let data = try encoder.encode(clothes)
            request.httpBody = data
            request.setValue(
                "application/json",
                forHTTPHeaderField: "Content-Type"
            )
            print(String(decoding: data, as: UTF8.self))
        default:
            break
        }
        print("[Router]: request \(String(describing: request.allHTTPHeaderFields))")
        return request
    }
}
