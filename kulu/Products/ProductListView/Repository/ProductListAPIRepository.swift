//
//  ProductListAPIRepository.swift
//  kulu
//
//  Created by Deepak Goyal on 09/06/26.
//

import Foundation

class ProductListAPIRepository: BasePaginatedAPIRepository {
    
    var service: BaseDataService = NetworkService.shared
    
    var firstPageIndex: Int = 0
    
    var currentPageIndex: Int = 0
    
    var hasMorePages: Bool = false
    
    private var limit = 20
    
    func handleCurrentPageIndex(for response: APIResponse<ProductListResponse>) {
        
        if case .success(let data) = response {
            hasMorePages = (data.data?.count ?? 0) == limit
            currentPageIndex = hasMorePages ? currentPageIndex + 1 : currentPageIndex
        }
    }

    
    func execute(_ completionHandler: @escaping (APIResponse<ProductListResponse>) -> Void){
        
        let request = APIRequest(method: .get, path: "products", body: nil, queryItems: ["page": "\(currentPageIndex)", "limit": "\(limit)"])
        service.fetch(request: request, responseType: ProductListResponse.self, completionHandler)
        
    }
    
}

struct ProductListResponse: Codable{
    
    var data: [Product]?
    
    enum CodingKeys: CodingKey {
        case data
    }
}
