//
//  APIConfig.swift
//  Outfit Calendar
//
//  Created by Han-Chih Chang on 2025/2/25.
//

import Foundation

struct APIConfig {
    static var baseURL: String? {
        get {
            if let path = Bundle.main.path(forResource: "env", ofType: "plist") {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                    do {
                        let plistData = try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
                        if let dict = plistData as? [String: Any] {
                            if let baseUrl = dict["BASE_URL"] as? String {
                                return baseUrl
                            }
                        }
                    } catch {
                        print("Error reading Plist: \(error)")
                    }
                }
            }
            return ""
        }
    }
}
