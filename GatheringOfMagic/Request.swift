//
//  Request.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 11/08/20.
//  Copyright © 2020 Eduardo Oliveira. All rights reserved.
//

import Foundation

enum CardError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct CardRequest {
    let resourceURL: URL
    let basicApi = "https://api.magicthegathering.io/v1/"
    
    init () {
        let resourceString = "\(basicApi)cards"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    init (name: String) {
        let resourceString = "\(basicApi)cards?name=\(name)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    func getCards (completion: @escaping(Result<[Card], CardError>) -> Void) {

    let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
        // O data contém os dados que requemos, mais ainda não estao no formato que queremos.
        guard let jsonData = data else {
            // Aqui utilizamos o Result caso não existam dados a serem pegos.
            completion(.failure(.noDataAvailable))
            return
        }
        do {
            // Aqui codificamos o formato JSON para um Cards.
            let decoder = JSONDecoder()
            let response = try decoder.decode(Cards.self, from: jsonData)
            // Aqui vamos níveis abaixo do response para termos um array de cards
            let cards = response.cards
            completion(.success(cards))
        } catch {
            completion(.failure(.canNotProcessData))
        }
    }
        dataTask.resume()
    }
}


