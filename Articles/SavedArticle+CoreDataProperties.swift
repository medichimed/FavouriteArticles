//
//  SavedArticle+CoreDataProperties.swift
//  
//
//  Created by Оксана Котілевська on 14.11.2020.
//
//

import Foundation
import CoreData


extension SavedArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedArticle> {
        return NSFetchRequest<SavedArticle>(entityName: "SavedArticle")
    }

    @NSManaged public var url: String?
    @NSManaged public var id: Int64
    @NSManaged public var publishedDate: String?
    @NSManaged public var title: String?
    @NSManaged public var author: String?

}
