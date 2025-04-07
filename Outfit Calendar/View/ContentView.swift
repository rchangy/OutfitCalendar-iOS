//
//  ContentView.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/2/10.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            ClosetView()
                .tabItem {
                    Text("Closet")
                }
            OutfitCalendarView()
                .tabItem {
                    Text("Calendar")
                }
        }
    }
}

#Preview {
    ContentView()
}
