//
//  ContentViewModel.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/3/9.
//

import Foundation

class DataViewModel: ObservableObject {
    
    @Published var clothes: [Clothes] = []
    
    var userId: UInt64 = 0
    let clothesRepository: ClothesRepository
    
    init(userId: UInt64, clothesRepository: ClothesRepository = ClothesRepository()) {
        self.userId = userId
        self.clothesRepository = clothesRepository
        fetchClothes()
    }
    
    func fetchClothes(){
        Task {
            do{
                let _clothes = try await clothesRepository.fetch(userId: userId)
                print(_clothes)
                await setClothes(clothes: _clothes)
            } catch {
                print("error: \(error)")
            }
        
        }
        
    }
    
    @MainActor
    func setClothes(clothes: [Clothes]){
        self.clothes = clothes
    }
    
}
