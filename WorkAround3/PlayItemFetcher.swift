//
//  PlayItemFetcher.swift
//  WorkAround3
//
//  Created by SeoGiwon on 24/12/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit
import CoreData

class PlayItemFetcher {
    
    private var fetchRequest: NSFetchRequest<PlayItem>!
    var context: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        
        self.fetchRequest = (UIApplication.shared.delegate as! AppDelegate).coreDataStack.allPlayItemsFetchRequest
        self.context = context
    }
    
    func playItems() -> [PlayItem] {
        
        var thePlayItems = [PlayItem]()
        
        if let items = try? self.context.fetch(fetchRequest) {
            thePlayItems = items
        }
        
        return thePlayItems
    }
    
    func playItem(from playItemId: Int) -> PlayItem? {
        
        let fetchRequest: NSFetchRequest<PlayItem> = PlayItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %d", playItemId)
        
        if let playItems = try? self.context.fetch(fetchRequest) {
            return playItems.first
        } else {
            return nil
        }
    }
}
