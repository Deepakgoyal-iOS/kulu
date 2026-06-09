//
//  Product.swift
//  kulu
//
//  Created by Deepak Goyal on 09/06/26.
//

import Foundation

struct Product: Codable{
    
    var id: UInt64?
    var title: String?
    var description: String?
    var category: String?
    var price: Double?
    var image: String?
    
    enum CodingKeys: String, CodingKey {
        case title, description, category, price, image, id
    }
}

