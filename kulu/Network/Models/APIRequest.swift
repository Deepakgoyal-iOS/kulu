//
//  APIRequest.swift
//  kulu
//
//  Created by Deepak Goyal on 08/06/26.
//

import Foundation

typealias JSONItem = [String: Any]
typealias QueryItems = [String: String]

struct APIRequest {
    
    enum Method: String {
        case get
        case post
        case put
        case delete
    }
    
    var method: Method

    var path: String
    
    var headers: [String: String]? = [:]
    
    var body: JSONItem? = nil
    
    var queryItems: QueryItems? = nil
    
    var baseURL: URL{
        return URL(string: "https://fakeapi.net")!
    }
}

