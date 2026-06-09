//
//  NetworkService.swift
//  kulu
//
//  Created by Deepak Goyal on 08/06/26.
//

import Foundation

class NetworkService: BaseDataService{
    
    static let shared = NetworkService()
    
    private init() { }
    
    private var requestInterceptor: [RequestInterceptor] = [NoInternetInterceptor()]
    
    func fetch<T: Decodable>(request: APIRequest, responseType: T.Type, _ completion: @escaping  (_ response: APIResponse<T>) -> Void) {
        
        var request = request
        
        let result = RequestInterceptorExecutor(interceptors: requestInterceptor, request: request, responseType: responseType).execute()
        
        switch result{
            
        case .modify(let _request):
            request = _request
            break
        case .respond(let result):
            completion(result)
            return
        }
        
        do{
            let httpRequest = try request.buildHttpRequest()
            
            fetchHttp(request: httpRequest, responseType: responseType, completion)
            
        }
        catch{
            completion(.failure(InternalError(error: error)))
        }
        
    }
    
    private func fetchHttp<T: Decodable>(request: URLRequest, responseType: T.Type, _ completion: @escaping  (_ response: APIResponse<T>) -> Void){
        
        HttpService.shared.send(request: request){ data, response, error in
            
            if let error {
                completion(.failure(InternalError(error: error)))
                return
            }
            
            completion(APIResponseHandler.handle(data, response: response, responseType: responseType))
            
        }
    }
    
}
private extension APIRequest{
    
    func buildHttpRequest() throws -> URLRequest {
        
        var urlComponents = URLComponents(string: baseURL.appendingPathComponent(path).absoluteString)
        urlComponents?.queryItems = queryItems?.map{ URLQueryItem(name: $0, value: $1) }
        
        guard let url = urlComponents?.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if let body{
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        }
        
        return request
    }
    
}
