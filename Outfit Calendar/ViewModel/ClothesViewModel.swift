//
//  ClothesViewModel.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/4/6.
//

import Foundation

class ClothesViewModel: ObservableObject {
    @Published var editingClothes: Clothes
    
    var userId: UInt64 = 0
    let clothesRepository: ClothesRepository
    init(userId: UInt64, clothes: Clothes, clothesRepository: ClothesRepository = ClothesRepository.shared) {
        self.userId = userId
        self.clothesRepository = clothesRepository
        self.editingClothes = clothes
    }
    
    func saveEditingClothes(){
        print("[ClothesViewModel] saving editing clothes...")
        Task {
            do {
                try await clothesRepository.update(data: editingClothes)
            } catch {
               print("[ClothesViewModel] an error occurred when saving editing clothes: \(error)")
            }
        }
    }
}
