//
//  OutfitView.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/4/7.
//

import SwiftUI

struct OutfitView: View {
    @Binding var wearingHistory: WearingHistory
    
    @ObservedObject var outfitViewModel: OutfitViewModel
    
    init(wearingHistory: Binding<WearingHistory>) {
        self._wearingHistory = wearingHistory
        self.outfitViewModel = OutfitViewModel(userId: 0, wearingHistory: wearingHistory.wrappedValue)
    }
    
    var body: some View {
        List {
            ForEach($outfitViewModel.clothes) { $clothes in
                ClothesListItemView(clothes: clothes)
            }
        }
    }
}

struct OutfitEditView: View {
    @Binding var wearingHistory: WearingHistory
    
    @ObservedObject var outfitEditViewModel = OutfitEditViewModel()
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar(identifier: .gregorian)
        var minDateComponents = DateComponents()
        minDateComponents.year = 1950
        return calendar.date(from: minDateComponents)!...Date.now
    }()
    
    var body: some View {
        Form {
            DatePicker("Date", selection: $wearingHistory.date, in: dateRange, displayedComponents: [.date])
            Picker("Clothes1", selection: $wearingHistory.cloth1) {
                Text("None").tag(nil as Int64?)
                ForEach($outfitEditViewModel.allClothes) { $clothes in
                    ClothesListItemView(clothes: clothes).tag(clothes.clothId)
                }
            }.pickerStyle(.navigationLink)
        }
    }
}


