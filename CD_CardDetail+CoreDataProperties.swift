//
//  CD_CardDetail+CoreDataProperties.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 07/10/22.
//
//

import Foundation
import CoreData


extension CD_CardDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CD_CardDetail> {
        return NSFetchRequest<CD_CardDetail>(entityName: "CD_CardDetail")
    }

    @NSManaged public var artist: String?
    @NSManaged public var cmc: Int32
    @NSManaged public var id: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var manaCost: String?
    @NSManaged public var name: String?
    @NSManaged public var power: String?
    @NSManaged public var rarity: String?
    @NSManaged public var toughness: String?
    @NSManaged public var type: String?
    @NSManaged public var quantity: Int16
    @NSManaged public var deck: CD_Deck?

}

extension CD_CardDetail : Identifiable {

}
