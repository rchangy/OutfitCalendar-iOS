//
//  ContentView.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/2/10.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var dataViewModel = DataViewModel(userId: 0)
    
    @State var addItemPresented = false
    
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
            }.toolbar{
                Button("Add Item"){
                    addItemPresented.toggle()
                }.sheet(isPresented: $addItemPresented, onDismiss: addItemDismiss){
                    ClothesEditView()
                }
            }
        }
    }
    
    func addItemDismiss(){
        dataViewModel.fetchClothes()
    }
}

#Preview {
    ContentView()
}
