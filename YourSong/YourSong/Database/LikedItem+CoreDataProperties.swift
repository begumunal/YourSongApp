//
//  LikedItem+CoreDataProperties.swift
//  YourSong
//
//  Created by Begum Unal on 13.05.2023.
//
//

import Foundation
import CoreData


extension LikedItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedItem> {
        return NSFetchRequest<LikedItem>(entityName: "LikedItem")
    }

    @NSManaged public var deviceID: String?
    @NSManaged public var id: Int32
    @NSManaged public var isLiked: Bool

}

extension LikedItem : Identifiable {

}
