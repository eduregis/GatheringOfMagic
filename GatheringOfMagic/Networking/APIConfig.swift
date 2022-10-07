//
//  APIConfig.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import Alamofire
import Foundation

//swiftlint:disable file_name

enum RequestMethod {
    case get
    case post
    case put
    case delete
}

extension RequestMethod {
    var alamofireMethod: HTTPMethod {
        switch self {
        case .get: return .get
        case .post: return .post
        case .put: return .put
        case .delete: return .delete
        }
    }
}

class EndPoint {
    
    static var selectedUrl: URL { URL(string: "https://api.magicthegathering.io/v1/")! }
    
    static let header = [
        "Content-Type": "application/json"
    ]
    
    static let brands = [
        "Content-Type": "application/json"
    ]
}

