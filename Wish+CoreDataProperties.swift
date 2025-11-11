//
//  Wish+CoreDataProperties.swift
//  ddshoshina@edu.hse.ru
//
//  Created by Диана on 11/11/2025.
//
//

import Foundation
import CoreData


extension Wish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wish> {
        return NSFetchRequest<Wish>(entityName: "Wish")
    }

    @NSManaged public var text: String?

}

extension Wish : Identifiable {

}
