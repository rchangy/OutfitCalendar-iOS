//
//  OutfitViewModel.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/4/8.
//

import Foundation

class OutfitViewModel: ObservableObject {
    @Published var clothes = [Clothes]()
    
    var userId: UInt64 = 0
    let wearingHistory: WearingHistory
    
    let clothesRepository: ClothesRepository
    let wearingHistoryRepository: WearingHistoryRepository
    
    init(userId: UInt64, wearingHistory: WearingHistory, clothesRepository: ClothesRepository = ClothesRepository.shared
         , wearingHistoryRepository: WearingHistoryRepository = WearingHistoryRepository.shared) {
        self.userId = userId
        self.clothesRepository = clothesRepository
        self.wearingHistoryRepository = wearingHistoryRepository
        self.wearingHistory = wearingHistory
        getClothesByWearingHistory()
    }
    
    func getClothesByWearingHistory(){
        Task {
            do{
                let allClothes = try await clothesRepository.fetch(userId: userId)
                var outfitClothes = [Clothes?]()
                if (wearingHistory.cloth1 != nil) { outfitClothes.append(getClothesById(allClothes: allClothes, clothId: wearingHistory.cloth1!)) }
                if (wearingHistory.cloth2 != nil) { outfitClothes.append(getClothesById(allClothes: allClothes, clothId: wearingHistory.cloth2!)) }
                if (wearingHistory.cloth3 != nil) { outfitClothes.append(getClothesById(allClothes: allClothes, clothId: wearingHistory.cloth3!)) }
                if (wearingHistory.cloth4 != nil) { outfitClothes.append(getClothesById(allClothes: allClothes, clothId: wearingHistory.cloth4!)) }
                if (wearingHistory.cloth5 != nil) { outfitClothes.append(getClothesById(allClothes: allClothes, clothId: wearingHistory.cloth5!)) }
                await setClothes(_clothes: outfitClothes.compactMap{ $0 })
            } catch {
                print("error: \(error)")
            }
        }
        
    }
    
    @MainActor
    func setClothes(_clothes: [Clothes]) {
        clothes = _clothes
    }
    
    func getClothesById(allClothes: [Clothes], clothId: Int64) -> Clothes? {
        let _clothes = allClothes.filter {
            $0.clothId == clothId
        }
        if _clothes.isEmpty { return nil }
        return _clothes.first
    }
}

class OutfitEditViewModel: ObservableObject {
    
    @Published var allClothes = [Clothes]()
    
    let clothesRepository: ClothesRepository
    var userId: UInt64 = 0
    
    init() {
        self.clothesRepository = ClothesRepository.shared
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
        self.allClothes = clothes
    }
}
