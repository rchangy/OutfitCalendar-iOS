//
//  Clothes.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/2/23.
//

import Foundation

struct Clothes: Decodable, Identifiable {
    
    let id = UUID()
    
    var clothId: Int64?
    var userId: Int64?
    var clothName: String?
    var category: String?
    var subcategory: String?
    var color: String?
    var usages: String?
    var image: String?
    var temperatureLevel: Int8?
    var imageContent: String?
    var temperatureMax: Int64?
    var temperatureMin: Int64?
    var season: String?
    
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
        case imageContent = "ImageContent"
        case temperatureMax = "TemperatureMax"
        case temperatureMin = "TemperatureMin"
        case season = "Season"
        
    }
}
