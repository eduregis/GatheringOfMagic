//
//  CardProvider.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import Moya

enum CardProvider {
    case getCards(page: Int, name: String)
    case getCardById(cardId: String)
}

extension CardProvider: TargetType {
    var baseURL: URL {
        return EndPoint.selectedUrl
    }
    
    var path: String {
        switch self {
        case .getCards: return "cards"
        case .getCardById(let cardId): return "cards/\(cardId)"
        }
    }
    
    var method: Method {
        switch self {
        case .getCards: return .get
        case .getCardById: return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getCards(let page, let name):
            return .requestParameters(
                parameters: [
                    "name": "\(name)",
                    "page": "\(page)",
                    "pageSize": "30",
                    "contains": "imageUrl"],
                encoding: URLEncoding.queryString)
        case .getCardById:
            return .requestPlain
        }
    
    }
    
    
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
