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

enum TypeOfRequest {
    case cards
    case sets
}

struct MTGRequest {
    let resourceURL: URL
    let basicApi = "https://api.magicthegathering.io/v1/"
    
    init (typeOfRequest: TypeOfRequest) {
        
        let resourceString: String
        switch typeOfRequest {
        case .cards:
            resourceString = "\(basicApi)cards"
        case .sets:
            resourceString = "\(basicApi)sets"
        }
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    init (typeOfRequest: TypeOfRequest, name: String) {
        
        let resourceString: String
        let filter = UserDefaults.standard.string(forKey: "filter")
        switch typeOfRequest {
        case .cards:
            resourceString = "\(basicApi)cards?\(filter ?? "name")=\(name)"
        case .sets:
            resourceString = "\(basicApi)sets/\(name)"
        }
        
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
    
    func getSets (completion: @escaping(Result<MTGSetDetails, CardError>) -> Void) {

    let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
        // O data contém os dados que requemos, mais ainda não estao no formato que queremos.
        print(self.resourceURL)
        guard let jsonData = data else {
            // Aqui utilizamos o Result caso não existam dados a serem pegos.
            completion(.failure(.noDataAvailable))
            return
        }
        do {
            // Aqui codificamos o formato JSON para um Cards.
            let decoder = JSONDecoder()
            let response = try decoder.decode(MTGSet.self, from: jsonData)
            // Aqui vamos níveis abaixo do response para termos um array de cards
            let set = response.set
            completion(.success(set))
        } catch {
            completion(.failure(.canNotProcessData))
        }
    }
        dataTask.resume()
    }
}
