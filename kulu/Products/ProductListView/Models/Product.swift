//
//  Product.swift
//  kulu
//
//  Created by Deepak Goyal on 09/06/26.
//

import Foundation

struct Product: Codable{
    
    struct Specs: Codable{
        var color: String?
        var capacity: String?
        var insulation: String?
        
        enum CodingKeys: String, CodingKey {
            case color
            case capacity
            case insulation
        }
        
    }
    
    struct Rating: Codable{
        var rate: Double?
        var count: Int?
        
        enum CodingKeys: String, CodingKey {
            case rate
            case count
        }
    }
    
    var id: UInt64?
    var title: String?
    var description: String?
    var category: String?
    var price: Double?
    var image: String?
    var brand: String?
    var stock: Double?
    var specs: Specs?
    var rating: Rating?
    
    enum CodingKeys: String, CodingKey {
        case title, description, category, price, image, id, stock, brand, specs, rating
    }
    
    func getAdditionalDetails() -> [String]{
        
        var details: [String] = []
        if let category{
            details.append("Category: \(category)")
        }
        
        if let brand{
            details.append("Brand: \(brand)")
        }
        
        if let stock{
            details.append("Stock: \(stock)")
        }
        
        if let capacity = specs?.capacity{
            details.append("Capacity: \(capacity)")
        }
        
        if let color = specs?.color{
            details.append("Color: \(color)")
        }
        
        if let insulation = specs?.insulation{
            details.append("Insulation: \(insulation)")
        }
        
        return details
    }
}

