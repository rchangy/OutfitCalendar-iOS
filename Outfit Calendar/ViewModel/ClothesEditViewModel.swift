//
//  ClothesEditViewModel.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/3/14.
//

import Foundation

class ClothesEditViewModel: ObservableObject {
    @Published var clothes: Clothes
    
    var userId: UInt64 = 0
    let clothesRepository: ClothesRepository
    
    init(userId: UInt64, clothes: Clothes, clothesRepository: ClothesRepository = ClothesRepository.shared) {
        self.userId = userId
        self.clothesRepository = clothesRepository
        self.clothes = clothes
    }
    
    func saveClothes(){
        print("[ClothesEditViewModel]: save clothes")
        Task {
            do {
                if(clothes.clothId == 0){
                    try await clothesRepository.create(data: clothes)
                } else {
                    try await clothesRepository.update(data: clothes)
                }
            } catch {
                print("[ClothesEditViewModel]: error occurred when saving clothes: \(error)")
            }
        }
        
    }
}
