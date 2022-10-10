//
//  CardDAO.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import Moya

class VehicleDAO {
    static func getCards(
        page: Int = 0,
        name: String = "",
        success: @escaping (Cards) -> Void,
        failure: @escaping (ErrorObject) -> Void) {
                
        let provider = MoyaProvider<CardProvider>()
            provider.request(.getCards(page: page, name: name), completion: { result in
            switch result {
            case .success(let response):
                guard let cards = try? response.map(Cards.self) else {
                    failure(ErrorObject(message: ErrorMessages.failureMock.localized()))
                    return
                }
                success(cards)
                
            case .failure(_):
                failure(ErrorObject(message: ErrorMessages.failureAPI.localized()))
            }
        })
    }
    
    static func getCardById(
        cardId: String = "",
        success: @escaping (CardDetail) -> Void,
        failure: @escaping (ErrorObject) -> Void) {
                
        let provider = MoyaProvider<CardProvider>()
            provider.request(.getCardById(cardId: cardId), completion: { result in
            switch result {
            case .success(let response):
                guard let cardResponse = try? response.map(CardResponse.self) else {
                    failure(ErrorObject(message: ErrorMessages.failureMock.localized()))
                    return
                }
                guard let card = cardResponse.card else { return }
                success(card)
            case .failure(_):
                failure(ErrorObject(message: ErrorMessages.failureAPI.localized()))
            }
        })
    }
}
