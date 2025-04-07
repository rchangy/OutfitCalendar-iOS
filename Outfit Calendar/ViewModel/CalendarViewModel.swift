//
//  CalendarViewModel.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/4/7.
//

import Foundation

class CalendarViewModel: ObservableObject {
    @Published var wearingHistory: [WearingHistory] = []
    
    var userId: UInt64 = 0
    let wearingHistoryRepository: WearingHistoryRepository
    
    init(userId: UInt64, wearingHistoryRepository: WearingHistoryRepository = WearingHistoryRepository()) {
        self.userId = userId
        self.wearingHistoryRepository = wearingHistoryRepository
        fetchWearingHistory()
    }
    
    func fetchWearingHistory() {
        print("[CalendarViewModel] fetching wearing history...")
        Task {
            do {
                let _wearingHistory = try await wearingHistoryRepository.fetch(userId: userId)
                print("[CalendarViewModel] wearing history fetched \(_wearingHistory)")
                await setWearingHistory(wearingHistory: _wearingHistory)
            } catch {
                print("[CalendarViewModel] an error occurred when fetching wearing history: \(error)")
            }
        }
    }
    
    @MainActor
    func setWearingHistory(wearingHistory: [WearingHistory]) {
        self.wearingHistory = wearingHistory
    }
}
