//
//  BaseAPIRepository.swift
//  kulu
//
//  Created by Deepak Goyal on 09/06/26.
//

import Foundation

protocol BaseAPIRepository {
    
    associatedtype ResponseType: Codable
    
    var service: BaseDataService { get set }
    
    func execute(_ completionHandler: @escaping ( _ response: APIResponse<ResponseType>) -> Void)
}

