//
//  ClothesView.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/3/13.
//

import Foundation
import SwiftUI

struct ClothesListItemView: View {
    var clothes: Clothes
    init(clothes: Clothes){
        self.clothes = clothes
    }
    
    var body: some View{
        HStack{
            Spacer()
            AsyncImage(url: nil)
                .frame(width: 50, height: 50)
            Spacer()
            VStack{
                Text(clothes.clothName)
            }
            Spacer()
        }
    }
}

struct ClothesView: View {
    @ObservedObject var clothesViewModel : ClothesViewModel
    
    @State var clothesEditViewPresented = false
    @State var clothes: Clothes
    
    init(clothes: Clothes){
        self.clothes = clothes
        self.clothesViewModel = ClothesViewModel(userId: 0, clothes: clothes)
    }
    
    var body: some View{
        VStack{
            HStack{
                Spacer()
                AsyncImage(url: nil)
                    .frame(width: 100, height: 100)
                Spacer()
                Text("Name: \(clothes.clothName)")
                Spacer()
            }
            HStack{
                VStack{
                    Text("Category:")
                    Text("Subcategory:")
                    Text("Color:")
                    Text("Usages:")
                    Text("Season:")
                }
                VStack{
                    Text(clothes.category)
                    Text(clothes.subcategory)
                    Text(clothes.color)
                    Text(clothes.usages)
                    Text(clothes.season)
                }
            }
        }
        .toolbar {
            Button("Edit") {
                clothesEditViewPresented = true
            }
            .sheet(isPresented: $clothesEditViewPresented){
                NavigationStack {
                    ClothesEditView(clothes: $clothesViewModel.editingClothes)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    clothesEditViewPresented = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    clothesEditViewPresented = false
                                    clothes = clothesViewModel.editingClothes
                                }
                            }
                        }
                }
            }
        }
    }
}

struct ClothesEditView: View {
    @Binding var clothes: Clothes
    
    var body: some View{
        VStack{
            HStack{
                Spacer()
                AsyncImage(url: nil)
                    .frame(width: 100, height: 100)
                Spacer()
                TextField(text: $clothes.clothName, prompt: Text("Clothes Name")){
                    Text("Name: ")
                }
                Spacer()
            }
            HStack{
                Form {
                    TextField(text: $clothes.category, prompt: Text("Category")) {
                        Text("Category")
                    }
                    TextField(text: $clothes.subcategory, prompt: Text("Subcategory")) {
                        Text("Subcategory")
                    }
                    TextField(text: $clothes.color, prompt: Text("Color")) {
                        Text("Color")
                    }
                    TextField(text: $clothes.usages, prompt: Text("Usages")) {
                        Text("Usages")
                    }
                    Picker("Season", selection: $clothes.temperatureLevel) {
                        Text("Spring").tag(0 as Int64)
                        Text("Summer").tag(1 as Int64)
                        Text("Fall").tag(2 as Int64)
                        Text("Winter").tag(3 as Int64)
                    }
                }
            }
            Spacer()
        }
    }
}
