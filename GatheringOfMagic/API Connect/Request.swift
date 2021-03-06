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
    
    var specifyColors: [String] = []
    
    init (typeOfRequest: TypeOfRequest) {
        
        let resourceString: String
        
        if UserDefaults.standard.bool(forKey: "whiteSwitch") { specifyColors.append("white") }
        if UserDefaults.standard.bool(forKey: "blueSwitch") { specifyColors.append("blue") }
        if UserDefaults.standard.bool(forKey: "blackSwitch") { specifyColors.append("black") }
        if UserDefaults.standard.bool(forKey: "redSwitch") { specifyColors.append("red") }
        if UserDefaults.standard.bool(forKey: "greenSwitch") { specifyColors.append("green") }
        
        var specifyColorsString: String = ""
        if specifyColors.count > 0 {
            specifyColorsString = specifyColors.joined(separator: ",")
            specifyColorsString = "colors=\(specifyColorsString)"
        }
        
        switch typeOfRequest {
        case .cards:
            
            if specifyColors.count > 0 {
                resourceString = "\(basicApi)cards?\(specifyColorsString)"
            } else {
                resourceString = "\(basicApi)cards"
            }
            
        case .sets:
            resourceString = "\(basicApi)sets"
        }
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    init (typeOfRequest: TypeOfRequest, name: String) {
        
        let resourceString: String
        let filter = UserDefaults.standard.string(forKey: "filter")
        
        let newName = name.replacingOccurrences(of: " ", with: "+")
        
        switch typeOfRequest {
        case .cards:
            resourceString = "\(basicApi)cards?\(filter ?? "name")=\(newName)"
        case .sets:
            resourceString = "\(basicApi)sets/\(newName)"
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
