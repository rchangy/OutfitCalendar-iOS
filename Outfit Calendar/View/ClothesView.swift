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
    var clothes: Clothes
    init(clothes: Clothes){
        self.clothes = clothes
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
            Spacer()
        }
    }
}

struct ClothesEditView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var clothesEditViewModel: ClothesEditViewModel
    
    init(clothes: Clothes = Clothes()){
        clothesEditViewModel = ClothesEditViewModel(userId: 0, clothes: clothes)
    }
    
    var body: some View{
        VStack{
            HStack{
                Spacer()
                AsyncImage(url: nil)
                    .frame(width: 100, height: 100)
                Spacer()
                TextField(text: $clothesEditViewModel.clothes.clothName, prompt: Text("Clothes Name")){
                    Text("Name: ")
                }
                Spacer()
            }
            HStack{
                Form {
                    TextField(text: $clothesEditViewModel.clothes.category, prompt: Text("Category")) {
                        Text("Category")
                    }
                    TextField(text: $clothesEditViewModel.clothes.subcategory, prompt: Text("Subcategory")) {
                        Text("Subcategory")
                    }
                    TextField(text: $clothesEditViewModel.clothes.color, prompt: Text("Color")) {
                        Text("Color")
                    }
                    TextField(text: $clothesEditViewModel.clothes.usages, prompt: Text("Usages")) {
                        Text("Usages")
                    }
                    Picker("Season", selection: $clothesEditViewModel.clothes.temperatureLevel) {
                        Text("Spring").tag(0 as Int64)
                        Text("Summer").tag(1 as Int64)
                        Text("Fall").tag(2 as Int64)
                        Text("Winter").tag(3 as Int64)
                    }
                }
            }
            Spacer()
        }
        HStack{
            Button("Save"){
                clothesEditViewModel.saveClothes()
                dismiss()
            }
            Button("Cancel"){
                dismiss()
            }
        }
    }
}
