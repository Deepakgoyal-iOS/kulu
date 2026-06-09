//
//  HttpService.swift
//  kulu
//
//  Created by Deepak Goyal on 08/06/26.
//

import Foundation

class HttpService{
    
    static let shared = HttpService()
    let session = URLSession.shared
    
    func send(request: URLRequest,_ completion: @escaping (Data?, URLResponse?, Error?) -> Void){
        
        session.dataTask(with: request, completionHandler: completion).resume()
    }
    
    func send(url: URL,_ completion: @escaping (Data?, URLResponse?, Error?) -> Void){
        
        session.dataTask(with: url, completionHandler: completion).resume()
    }
}
