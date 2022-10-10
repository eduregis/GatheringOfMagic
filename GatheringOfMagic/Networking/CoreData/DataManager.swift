//
//  DataManager.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 07/10/22.
//

//
//  DataManager.swift
//  CoreDataRelationship
//
//  Created by Megi Sila on 2.5.22.
//  Copyright © 2022 Megi Sila. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    
    static let shared = DataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("\(ErrorMessages.unresolvedError.localized()) \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func createDeck(name: String, coverId: String, format: String) -> CD_Deck {
        let deck = CD_Deck(context: persistentContainer.viewContext)
        deck.name = name
        deck.coverId = coverId
        deck.format = format
        return deck
    }
    
    func createCard(artist: String, cmc: Int32, id: String, imageUrl: String, manaCost: String, name: String, power: String, rarity: String, toughness: String, type: String, deck: CD_Deck) -> CD_CardDetail {
        let card = CD_CardDetail(context: persistentContainer.viewContext)
        card.artist = artist
        card.cmc = cmc
        card.id = id
        card.imageUrl = imageUrl
        card.manaCost = manaCost
        card.name = name
        card.power = power
        card.quantity = 1
        card.rarity = rarity
        card.toughness = toughness
        card.type = type
        deck.addToCards(card)
        return card
    }
    
    func getDecks() -> [CD_Deck] {
        let request: NSFetchRequest<CD_Deck> = CD_Deck.fetchRequest()
        var fetchedDecks: [CD_Deck] = []
        
        do {
            fetchedDecks = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("\(ErrorMessages.errorFetchingDecks.localized()) \(error)")
        }
        return fetchedDecks
    }
    
    func getDeckByName(name: String) -> CD_Deck? {
        let request: NSFetchRequest<CD_Deck> = CD_Deck.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        var fetchedDeck: CD_Deck?
        do {
            fetchedDeck = try persistentContainer.viewContext.fetch(request).first
        } catch let error {
            print("\(ErrorMessages.errorFetchingCards.localized()) \(error)")
        }
        return fetchedDeck
    }
    
    func getCards(deck: CD_Deck) -> [CD_CardDetail] {
        let request: NSFetchRequest<CD_CardDetail> = CD_CardDetail.fetchRequest()
        request.predicate = NSPredicate(format: "deck = %@", deck)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        var fetchedCards: [CD_CardDetail] = []
        
        do {
            fetchedCards = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("\(ErrorMessages.errorFetchingCards.localized()) \(error)")
        }
        return fetchedCards
    }
    
    // MARK: - Core Data Saving support
    func save () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("\(ErrorMessages.unresolvedError.localized()) \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteCard(card: CD_CardDetail) {
        let context = persistentContainer.viewContext
        context.delete(card)
        save()
    }
    
    func deleteDeck(deck: CD_Deck) {
        let context = persistentContainer.viewContext
        context.delete(deck)
        save()
    }
}

