//
//  ContentView.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/2/10.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var dataViewModel = DataViewModel(userId: 0)
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(dataViewModel.clothes) { clothes in
                    NavigationLink{
                        ClothesView(clothes: clothes)
                    } label: {
                        ClothesListItemView(clothes: clothes)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
