//
//  CoreDataStack.swift
//  WorkAround3
//
//  Created by SeoGiwon on 22/09/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStack {
    
    var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - init
    init() {
        // put sample data
        let fetchRequest: NSFetchRequest<PlayItem> = PlayItem.fetchRequest()
        guard let cnt = try? persistentContainer.viewContext.count(for: fetchRequest) else {
            return;
        }
        
        if (cnt == 0) {
            
            print("will put sample data")
            
            insertSamplePlayItems(context: persistentContainer.viewContext)
            
            print("did put sample data")
            return
        }
    }
    
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Core Data record adding/fetching
    func insertPlayItem(context: NSManagedObjectContext) -> PlayItem {
        let playItem = PlayItem(context: context)
        return playItem
    }

    private func insertSamplePlayItems(context: NSManagedObjectContext) {
        guard let playItemDictArray = ResourceReadingHelper.playItemDictArray() else {
            fatalError()
        }
        
        var playItems = [PlayItem]()
        
        for (i,v) in playItemDictArray.enumerated() {
            
            guard let showName = v["show_name"] as? String,
                let title = v["title"] as? String,
                let description = v["description"] as? String,
                let duration = v["duration"] as? NSNumber,
                let publishedDateString = v["published_date"] as? String,
                let thumbnailName = v["thumbnail_image_name_in_bundle"] as? String,
                let fileName = v["mp3_file_name_in_bundle"] as? String else {
                    
                    continue
            }
            
            
            guard let thumbnailImage = UIImage(named: thumbnailName) else {
                continue
            }
            
            var date: Date {
                let formatter = DateFormatter()
                formatter.dateFormat = "E, d MMM yyyy HH:mm:ss z"
                return formatter.date(from: publishedDateString)!
            }
            
            /*
             "show_name": "Snap Judgement",
             "title": "Snap #920 - Campfire Tales V",
             "description": "An all new season of Spooked, the podcast, is dropping early August. In this episode, we’re featuring some of our favorite stories from Spooked, season one.",
             "duration": 3309,
             "published_date": "Thu, 19 Jul 2018 12:00:00 EDT",
             "thumbnail_image_name_in_bundle": "snap_920.png",
             "mp3_file_name_in_bundle": "snap_920.mp3"
             */
            
            let playItem = PlayItem(context: context)
            playItem.title = title
            playItem.thumbnail = UIImagePNGRepresentation(thumbnailImage) as NSData?
            playItem.duration = duration.doubleValue
            playItem.showname = showName
            playItem.publishedDate = date as NSDate
            playItem.playHead = 0.0
            playItem.desc = description
            playItem.fileName = fileName
            playItem.id = Int16(i)
            playItems.append(playItem)
        }
        
        try? context.save()
    }
    
    // MARK: - fetch
    func allPlayItems(context: NSManagedObjectContext) -> [PlayItem] {
        
        var thePlayItems = [PlayItem]()
        let fetchRequest:NSFetchRequest<PlayItem> = PlayItem.fetchRequest()
        
        if let items = try? context.fetch(fetchRequest) {
            thePlayItems = items
        }
        
        return thePlayItems
    }
    
    func playItem(of playItemId: Int, context: NSManagedObjectContext) -> PlayItem? {
        
        let fetchRequest: NSFetchRequest<PlayItem> = PlayItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %d", playItemId)
        
        if let playItems = try? context.fetch(fetchRequest) {
            return playItems.first
        } else {
            return nil
        }
    }
}
