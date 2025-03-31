//
//  Clothes.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/2/23.
//

import Foundation

struct Clothes: Codable, Identifiable {
    
    let id = UUID()
    
    var clothId: Int64 = 0
    var userId: Int64 = 0
    var clothName: String = ""
    var category: String = ""
    var subcategory: String = ""
    var color: String = ""
    var usages: String = ""
    var image: String = ""
    var temperatureLevel: Int64 = 0
    var imageContent: String = ""
    var temperatureMax: Int64 = 0
    var temperatureMin: Int64 = 0
    var season: String = "Spring"
    
    private enum CodingKeys: String, CodingKey {
        case clothId = "ClothId"
        case userId = "UserId"
        case clothName = "ClothName"
        case category = "Category"
        case subcategory = "Subcategory"
        case color = "Color"
        case usages = "Usages"
        case image = "Image"
        case temperatureLevel = "TemperatureLevel"
        case imageContent = "image_content"
//        case temperatureMax = "TemperatureMax"
//        case temperatureMin = "TemperatureMin"
//        case season = "Season"
        
    }
}
