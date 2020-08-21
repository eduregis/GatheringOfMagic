//
//  FavoritesViewController.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 15/08/20.
//  Copyright © 2020 Eduardo Oliveira. All rights reserved.
//

import Foundation

enum ListOfCards {
    case favoriteCards
}

enum ListOfDecks {
    case deckList
}

class Database {
    
    var favoriteCards: URL
    var decks: URL
    
    var emptyArray = [Card]()
    var emptyDeckList = [Deck]()
    
    //Singleton: Access by using Database.shared.<function-name>
    static let shared = Database()
    
    init() {
        let documentsFolder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let favoriteCardsFileName = "favoriteCards.json"
        let decksFileName = "decks.json"
        
        favoriteCards = documentsFolder.appendingPathComponent(favoriteCardsFileName)
        decks = documentsFolder.appendingPathComponent(decksFileName)
        
        //Caso os arquivos não existam, eles são criados no init
        if !(FileManager.default.fileExists(atPath: favoriteCards.path)) {
            saveData(from: emptyArray, to: .favoriteCards)
        }
        if !(FileManager.default.fileExists(atPath: decks.path)) {
            saveData(from: emptyDeckList, to: .deckList)
        }
        
    }
    
    func loadData(from list: ListOfCards) -> [Card] {
        var type: URL
        var loadedArray: [Card] = []
        
        switch list {
        case .favoriteCards:
            type = favoriteCards
        }
        
        do {
            let fileToBeRead = try Data(contentsOf: type)
            loadedArray = try JSONDecoder().decode([Card].self, from: fileToBeRead)
        } catch {
            print(error.localizedDescription)
        }
        
        return loadedArray
    }
    
    func loadData(from list: ListOfDecks) -> [Deck] {
        var type: URL
        var loadedArray: [Deck] = []
        
        switch list {
        case .deckList:
            type = decks
        }
        
        do {
            let fileToBeRead = try Data(contentsOf: type)
            loadedArray = try JSONDecoder().decode([Deck].self, from: fileToBeRead)
        } catch {
            print(error.localizedDescription)
        }
        
        return loadedArray
    }
    
    func saveData(from array: [Card], to list: ListOfCards) {
        
        var type: URL
        
        switch list {
        case .favoriteCards:
            type = favoriteCards
            
            do {
                let jsonData = try JSONEncoder().encode(array)
                try jsonData.write(to: type)
            } catch {
                print("Impossível escrever no arquivo.")
            }
        }
    }
    
    func saveData(from array: [Deck], to list: ListOfDecks) {
        
        var type: URL
        
        switch list {
        case .deckList:
            type = decks
            
            do {
                let jsonData = try JSONEncoder().encode(array)
                try jsonData.write(to: type)
            } catch {
                print("Impossível escrever no arquivo.")
            }
        }
    }
    
    func deleteCard(from list: ListOfCards, at card: Card) {
        var loadedArray = loadData(from: list)
        if let index = loadedArray.firstIndex(of: card) {
            loadedArray.remove(at: index)
            saveData(from: loadedArray, to: list)
        }
    }
    
    func deleteDeck(from list: ListOfDecks, at deck: Deck) {
        var loadedArray = loadData(from: list)
        if let index = loadedArray.firstIndex(of: deck) {
            loadedArray.remove(at: index)
            saveData(from: loadedArray, to: list)
        }
    }
    
    func deleteAllCards(from list: ListOfCards) {
        
        var loadedArray = loadData(from: list)
        loadedArray.removeAll()
        saveData(from: loadedArray, to: list)
    }
    
    func deleteAllDecks(from list: ListOfDecks) {
        
        var loadedArray = loadData(from: list)
        loadedArray.removeAll()
        saveData(from: loadedArray, to: list)
    }
    
    func loadFavoriteCards(from type: ListOfCards) -> [Card] {
        let favoriteCards = loadData(from: type)
        return favoriteCards
    }
    
    func loadDecks(from type: ListOfDecks) -> [Deck] {
        let decks = loadData(from: type)
        return decks
    }
}
