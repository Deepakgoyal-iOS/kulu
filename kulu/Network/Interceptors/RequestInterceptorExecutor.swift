//
//  RequestInterceptorExecutor.swift
//  kulu
//
//  Created by Deepak Goyal on 09/06/26.
//

class RequestInterceptorExecutor<T: Decodable>{
    
    var interceptors: [RequestInterceptor]
    var request: APIRequest
    var responseType: T.Type
    
    init(interceptors: [RequestInterceptor], request: APIRequest, responseType: T.Type) {
        self.interceptors = interceptors
        self.request = request
        self.responseType = responseType
    }
    
    func execute() -> RequestInterceptorResult<T>{
        
        for interceptor in interceptors {
           
            guard interceptor.shouldIntercept(request: request, responseType: responseType) else {
                continue
            }
            let result = interceptor.intercept(request: request, responseType: responseType)
            
            switch result {
            case .modify(let modifiedRequest):
                self.request = modifiedRequest
            case .respond(_):
                return result
            }
        }
        
        return .modify(request)
    }
}
