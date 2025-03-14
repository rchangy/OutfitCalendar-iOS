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
    var clothes: Clothes
    @State var tmpClothes: Clothes
    
    init(clothes: Clothes = Clothes()){
        self.clothes = clothes
        tmpClothes = Clothes()
    }
    
    var body: some View{
        VStack{
            HStack{
                Spacer()
                AsyncImage(url: nil)
                    .frame(width: 100, height: 100)
                Spacer()
                TextField(text: $tmpClothes.clothName, prompt: Text("Clothes Name")){
                    Text("Name: ")
                }
                Spacer()
            }
            HStack{
                Form {
                    TextField(text: $tmpClothes.category, prompt: Text("Category")) {
                        Text("Category")
                    }
                    TextField(text: $tmpClothes.subcategory, prompt: Text("Subcategory")) {
                        Text("Subcategory")
                    }
                    TextField(text: $tmpClothes.color, prompt: Text("Color")) {
                        Text("Color")
                    }
                    TextField(text: $tmpClothes.usages, prompt: Text("Usages")) {
                        Text("Usages")
                    }
                    Picker("Season", selection: $tmpClothes.temperatureLevel) {
                        Text("Spring").tag(0 as Int64)
                        Text("Summer").tag(1 as Int64)
                        Text("Fall").tag(2 as Int64)
                        Text("Winter").tag(3 as Int64)
                    }
                }
            }
            Spacer()
        }
        Button("Cancel"){
            dismiss()
        }
    }
}
