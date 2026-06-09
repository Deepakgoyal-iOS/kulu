//
//  NoInternetInterceptor.swift
//  kulu
//
//  Created by Deepak Goyal on 09/06/26.
//

import Foundation

class NoInternetInterceptor: RequestInterceptor{
    
    func intercept<T>(request: APIRequest, responseType: T.Type) -> RequestInterceptorResult<T> where T : Decodable {
        return .respond(.failure(InternalError(error: URLError(.notConnectedToInternet))))
    }
    
    func shouldIntercept<T>(request: APIRequest, responseType: T.Type) -> Bool where T : Decodable  {
        return false
    }
}
