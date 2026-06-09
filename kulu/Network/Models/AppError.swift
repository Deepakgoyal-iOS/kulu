//
//  AppError.swift
//  kulu
//
//  Created by Deepak Goyal on 08/06/26.
//

import Foundation

protocol AppError{
    
    var statusCode: Int { get }
    
    var message: String { get }
}

struct InternalError: AppError{
    
    private var error: Error
    
    var statusCode: Int {
        return -1
    }
    
    var message: String {
        return error.localizedDescription
    }
    
    init(error: Error){
        self.error = error
    }
    
}

struct APIError: AppError, Codable{
    
    var statusCode: Int = 100 // dummy
    
    var message: String = "API error"
}
