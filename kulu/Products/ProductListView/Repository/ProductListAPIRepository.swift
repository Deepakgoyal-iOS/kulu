//
//  ProductListAPIRepository.swift
//  kulu
//
//  Created by Deepak Goyal on 09/06/26.
//

import Foundation

class ProductListAPIRepository: BasePaginatedAPIRepository {
    
    var service: BaseDataService = NetworkService.shared
    
    var firstPageIndex: Int = 1
    
    var currentPageIndex: Int = 1
    
    var hasMorePages: Bool = false
    
    func hasNextPage() -> Bool {
        return true
    }
    
    func execute(_ completionHandler: @escaping (APIResponse<ProductListResponse>) -> Void){
        
        let request = APIRequest(method: .get, path: "products", body: nil, queryItems: ["page": "\(firstPageIndex)", "limit": "10", "category": "electronics"])
        service.fetch(request: request, responseType: ProductListResponse.self, completionHandler)
        
    }
    
}

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

struct ProductListResponse: Codable{
    
    var data: [Product]?
    
    enum CodingKeys: CodingKey {
        case data
    }
}
