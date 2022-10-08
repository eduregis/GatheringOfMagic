//
//  CD_Deck+CoreDataProperties.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 07/10/22.
//
//

import Foundation
import CoreData


extension CD_Deck {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CD_Deck> {
        return NSFetchRequest<CD_Deck>(entityName: "CD_Deck")
    }

    @NSManaged public var coverId: String?
    @NSManaged public var format: String?
    @NSManaged public var name: String?
    @NSManaged public var cards: NSSet?

}

// MARK: Generated accessors for cards
extension CD_Deck {

    @objc(addCardsObject:)
    @NSManaged public func addToCards(_ value: CD_CardDetail)

    @objc(removeCardsObject:)
    @NSManaged public func removeFromCards(_ value: CD_CardDetail)

    @objc(addCards:)
    @NSManaged public func addToCards(_ values: NSSet)

    @objc(removeCards:)
    @NSManaged public func removeFromCards(_ values: NSSet)

}

extension CD_Deck : Identifiable {

}
