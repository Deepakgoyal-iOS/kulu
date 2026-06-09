//
//  BasePaginatedAPIRepository.swift
//  kulu
//
//  Created by Deepak Goyal on 09/06/26.
//

import Foundation

protocol BasePaginatedAPIRepository: AnyObject, BaseAPIRepository{

    var firstPageIndex: Int { get }
    
    var currentPageIndex: Int { get set }
    
    var hasMorePages: Bool { get set}
    
    func handleCurrentPageIndex(for response: APIResponse<ResponseType>)
    
}
extension BasePaginatedAPIRepository{
    
    func fetchFirstPage(_ completionHandler: @escaping ( _ response: APIResponse<ResponseType>) -> Void){
        
        currentPageIndex  = firstPageIndex
        resumeExecution(completionHandler)
    }
    
    func fetchNextPage(_ completionHandler: @escaping ( _ response: APIResponse<ResponseType>) -> Void){
        resumeExecution(completionHandler)
    }
    
    private func resumeExecution(_ completionHandler: @escaping ( _ response: APIResponse<ResponseType>) -> Void){
        
        execute(){ [weak self] response in
            completionHandler(response)
            self?.handleCurrentPageIndex(for: response)
        }
    }
    
}

