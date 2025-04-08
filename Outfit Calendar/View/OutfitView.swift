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
