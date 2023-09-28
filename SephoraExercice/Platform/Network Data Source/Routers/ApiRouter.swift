//
//  ApiRouter.swift
//  SephoraExercice
//
//  Created by Firas on 27/09/2023.
//

import Foundation

enum ApiRouter {
    case getProducts
    
    var path: String {
        switch self {
        case .getProducts:
            return "items.json"
        }
    }
    
    // MARK: URLRequestConvertible
    func asURL() throws -> URL{
        URL(string: Environment.APIBasePath() + path)!
    }
}
           
