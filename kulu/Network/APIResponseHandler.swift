//
//  APIResponseHandler.swift
//  kulu
//
//  Created by Deepak Goyal on 09/06/26.
//

import Foundation

class APIResponseHandler{
    
    private init(){ }
    
    static func handle<T: Decodable>(_ data: Data?, response: URLResponse?, responseType: T.Type) -> APIResponse<T> {
        
        guard let _response = response as? HTTPURLResponse, let data else {
            return .failure(InternalError(error: URLError(.badServerResponse)))
        }
        
        do{
            if _response.statusCode == 200{
                let result = try JSONDecoder().decode(responseType, from: data)
                 return .success(result)
            }
            else {
                let result = try JSONDecoder().decode(APIError.self, from: data)
                return .failure(result)
            }
        }
        catch {
            return .failure(InternalError(error: error))
        }
    }
}
