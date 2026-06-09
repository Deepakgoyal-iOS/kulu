//
//  APIResponse.swift
//  kulu
//
//  Created by Deepak Goyal on 08/06/26.
//

import Foundation

enum APIResponse<T: Decodable>{
    
    case success(_ data: T)
    case failure(_ error: AppError)
}
