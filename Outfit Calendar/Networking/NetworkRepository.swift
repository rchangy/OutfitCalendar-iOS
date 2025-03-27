//
//  NetworkRepository.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/3/7.
//

import Foundation

class ClothesRepository {
    static let shared = ClothesRepository()
    
    let service: ClothesNetworkService
    
    init(service: ClothesNetworkService = ClothesNetworkService()) {
        self.service = service
    }
    
    func fetch(userId: UInt64) async throws -> [Clothes] {
        return try await service.fetchByUser(userId: userId)
    }
    
    func create(data: Clothes) async throws {
        try await service.create(data: data)
    }
    
    func update(data: Clothes) async throws {
        try await service.update(data: data)
    }
    
    func remove(data: Clothes) async throws {
        try await service.remove(data: data)
    }
}
