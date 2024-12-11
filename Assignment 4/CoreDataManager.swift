//
//  CoreDataManager.swift
//  Assignment 4
//
//  Created by Aniket Saxena on 2024-12-10.
//

import Foundation
import CoreData

class CoreDataManager {
    // MARK: - Singleton Instance
    static let shared = CoreDataManager()

    // Private initializer to enforce singleton usage
    private init() {}

    // MARK: - Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Assignment_4")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Core Data Saving Support
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // MARK: - Core Data CRUD Operations
    // Save a new record
    func saveImage(title: String, date: String, explanation: String, imageData: Data) {
        let savedImage = SavedImage(context: context)
        savedImage.title = title
        savedImage.date = date
        savedImage.explanation = explanation
        savedImage.imageData = imageData

        saveContext()
    }

    // Fetch all saved records
    func fetchSavedImages() -> [SavedImage] {
        let fetchRequest: NSFetchRequest<SavedImage> = SavedImage.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching saved images: \(error)")
            return []
        }
    }

    // Delete a specific record
    func deleteImage(_ savedImage: SavedImage) {
        context.delete(savedImage)
        saveContext()
    }
}
