//
//  OutfitView.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/4/7.
//

import SwiftUI

struct OutfitView: View {
    @Binding var wearingHistory: WearingHistory
    
    var body: some View {
        Text("\(wearingHistory.cloth1 ?? 0)")
    }
}
