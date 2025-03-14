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
                Text(clothes.clothName ?? "")
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
                Text("Name: \(clothes.clothName ?? "")")
                Spacer()
            }
            HStack{
                VStack{
                    Text("Category:")
                    Text("Sbucategory:")
                    Text("Color:")
                    Text("Usages:")
                    Text("Season:")
                }
                VStack{
                    Text(clothes.category ?? "")
                    Text(clothes.subcategory ?? "")
                    Text(clothes.color ?? "")
                    Text(clothes.usages ?? "")
                    Text(clothes.season ?? "")
                }
            }
            Spacer()
        }
    }
}

struct ClothesEditView {
    
}
