//
//  BaseDataService.swift
//  kulu
//
//  Created by Deepak Goyal on 08/06/26.
//

import Foundation

protocol BaseDataService {
    
    func fetch<T: Decodable>(request: APIRequest, responseType: T.Type, _ completion: @escaping (_ response: APIResponse<T>) -> Void)
}
