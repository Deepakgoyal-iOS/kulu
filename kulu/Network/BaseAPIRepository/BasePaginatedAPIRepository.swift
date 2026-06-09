//
//  BasePaginatedAPIRepository.swift
//  kulu
//
//  Created by Deepak Goyal on 09/06/26.
//

import Foundation

protocol BasePaginatedAPIRepository: BaseAPIRepository{

    var firstPageIndex: Int { get }
    
    var currentPageIndex: Int { get set }
    
    var hasMorePages: Bool { get set}
    
    func hasNextPage() -> Bool
}
extension BasePaginatedAPIRepository{
    
    mutating func firstPage(_ completionHandler: @escaping ( _ response: APIResponse<ResponseType>) -> Void){
        
        currentPageIndex  = firstPageIndex
        hasMorePages = true
        execute(completionHandler)
        hasMorePages = hasNextPage()
    }
    
    mutating func nextPage(_ completionHandler: @escaping ( _ response: APIResponse<ResponseType>) -> Void){
        
        currentPageIndex+=1
        execute(completionHandler)
        hasMorePages = hasNextPage()
    }
    
}

