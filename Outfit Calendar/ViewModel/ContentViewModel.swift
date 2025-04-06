//
//  ContentViewModel.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/3/9.
//

import Foundation

class DataViewModel: ObservableObject {
    @Published var clothes: [Clothes] = []
    @Published var newClothes = Clothes()
    
    var userId: UInt64 = 0
    let clothesRepository: ClothesRepository
    
    init(userId: UInt64, clothesRepository: ClothesRepository = ClothesRepository.shared) {
        self.userId = userId
        self.clothesRepository = clothesRepository
        fetchClothes()
    }
    
    func fetchClothes(){
        Task {
            do{
                let _clothes = try await clothesRepository.fetch(userId: userId)
                print("[ContentViewModel]: clothes fetched \(_clothes)")
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
    
    func addClothes() {
        print("[ContentViewModel] adding new clothes...")
        Task {
            do {
                try await clothesRepository.create(data: newClothes)
            } catch {
                print("[ContentViewModel] an error occurred when adding new clothes: \(error)")
            }
        }
        fetchClothes()
        newClothes = Clothes()
    }
}
