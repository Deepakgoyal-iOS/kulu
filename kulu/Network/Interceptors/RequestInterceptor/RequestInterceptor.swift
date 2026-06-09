//
//  RequestInterceptor.swift
//  kulu
//
//  Created by Deepak Goyal on 09/06/26.
//

import Foundation

protocol RequestInterceptor{
    
    func intercept<T: Decodable>(request: APIRequest, responseType: T.Type) -> RequestInterceptorResult<T>
    
    func shouldIntercept<T: Decodable>(request: APIRequest, responseType: T.Type) -> Bool
}
