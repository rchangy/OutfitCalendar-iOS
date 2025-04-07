//
//  ClosetView.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/4/6.
//

import Foundation
import SwiftUI

struct ClosetView: View {
    @ObservedObject var closetViewModel = ClosetViewModel(userId: 0)
    
    @State var addItemPresented = false
    
    var body: some View {
        NavigationStack{
            List {
                ForEach($closetViewModel.clothes) { $clothes in
                    NavigationLink{
                        ClothesView(clothes: $clothes, editingClothes: clothes)
                    } label: {
                        ClothesListItemView(clothes: clothes)
                    }
                }
                .onDelete(perform: closetViewModel.deleteClothes)
            }.toolbar{
                Button("Add"){
                    addItemPresented = true
                }.sheet(isPresented: $addItemPresented){
                    NavigationStack {
                        ClothesEditView(clothes: $closetViewModel.newClothes)
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Cancel") {
                                        addItemPresented = false
                                    }
                                }
                                ToolbarItem(placement: .confirmationAction) {
                                    Button("Add") {
                                        addItemPresented = false
                                        closetViewModel.addClothes()
                                    }
                                }
                            }
                    }
                }
            }
        }
    }
}
