//
//  CoreDataManager.swift
//  ddshoshina@edu.hse.ru
//
//  Created by Диана on 11/11/2025.
//

import Foundation
import CoreData

final class CoreDataManager {

    static let shared = CoreDataManager()
    private let container: NSPersistentContainer

    var context: NSManagedObjectContext {
        container.viewContext
    }

    private init() {
        container = NSPersistentContainer(name: "WishModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data store: \(error)")
            }
        }
    }

    // MARK: - Save

    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }

    // MARK: - CRUD for Wish

    func fetchWishes() -> [Wish] {
        let request: NSFetchRequest<Wish> = Wish.fetchRequest()
        request.sortDescriptors = []

        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch wishes: \(error)")
            return []
        }
    }

    @discardableResult
    func addWish(text: String) -> Wish {
        let wish = Wish(context: context)
        wish.text = text
        saveContext()
        return wish
    }

    func deleteWish(_ wish: Wish) {
        context.delete(wish)
        saveContext()
    }

    func updateWish(_ wish: Wish, newText: String) {
        wish.text = newText
        saveContext()
    }
}
