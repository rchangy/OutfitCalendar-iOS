//
//  NetworkService.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/2/26.
//

import Foundation

protocol UserDataServiceProtocol {
    associatedtype Entity : Decodable
    func fetchByUser(userId: UInt64) async throws -> [Entity]
    func create(data: Entity) async throws
    func update(data: Entity) async throws
    func remove(data: Entity) async throws
}

class BaseNetworkService<Router: URLRequestConvertible> {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    private func handleResponse(data: Data, response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
        }
    }
    
    func request<T: Decodable>(_ returnType: T.Type, router: Router) async throws -> T {
        let request = try router.makeURLRequest()
        let (data, response) = try await urlSession.data(for: request)
        try handleResponse(data: data, response: response)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        do {
            
            let decodedData = try decoder.decode(returnType, from: data)
            return decodedData
        } catch {
            throw NetworkError.dataConversionFailure
        }
    }
}

class ClothesNetworkService: BaseNetworkService<ClothesRouter>, UserDataServiceProtocol {
    func fetchByUser(userId: UInt64) async throws -> [Clothes] {
        return try await request([Clothes].self, router: .fetchClothes(userId: userId))
    }
    
    func create(data: Clothes) async throws {
        _ = try await request(Clothes.self, router: .createClothes(clothes: data))
    }
    
    func update(data: Clothes) async throws {
        _ = try await request(Clothes.self, router: .updateClothes(clothes: data))
    }
    
    func remove(data: Clothes) async throws {
        _ = try await request(Clothes.self, router: .removeClothes(clothes: data))
    }
}

class WearingHistoryNetworkService: BaseNetworkService<WearingHistoryRouter>, UserDataServiceProtocol {
    func fetchByUser(userId: UInt64) async throws -> [WearingHistory] {
        return try await request([WearingHistory].self, router: .fetchWearingHistory(userId: userId))
    }
    
    func create(data: WearingHistory) async throws {
        _ = try await request(WearingHistory.self, router: .createWearingHistory(wearingHistory: data))
    }
    
    func update(data: WearingHistory) async throws {
        _ = try await request(WearingHistory.self, router: .updateWearingHistory(wearingHistory: data))
    }
    
    func remove(data: WearingHistory) async throws {
        _ = try await request(WearingHistory.self, router: .removeWearingHistory(wearingHistory: data))
    }
    
}
