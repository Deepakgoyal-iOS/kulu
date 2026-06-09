//
//  RequestInterceptorResult.swift
//  kulu
//
//  Created by Deepak Goyal on 09/06/26.
//

import Foundation

enum RequestInterceptorResult<T: Decodable>{
    
    case respond(_ result: APIResponse<T>)
    
    case modify(_ request: APIRequest)
}
