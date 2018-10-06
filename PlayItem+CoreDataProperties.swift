//
//  PlayItem+CoreDataProperties.swift
//  WorkAround3
//
//  Created by SeoGiwon on 26/07/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

extension PlayItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayItem> {
        return NSFetchRequest<PlayItem>(entityName: "PlayItem")
    }

    @NSManaged public var title: String?
    @NSManaged public var thumbnail: NSData?
    @NSManaged public var duration: Double
    @NSManaged public var showname: String?
    @NSManaged public var publishedDate: NSDate?
    @NSManaged public var playHead: Double
    @NSManaged public var desc: String?
    @NSManaged public var fileName: String?


    static func samplePlayItems(context: NSManagedObjectContext) -> [PlayItem]? {
    
        let playItems = ResourceReadingHelper.readPlayItemJsonFile(context: context)
        return playItems
    }

    
    static func playItem(context: NSManagedObjectContext, title: String, thumbnail: UIImage, duration: Double, showname: String, publishedDate: Date, playHead: Double, desc: String, fileName: String) -> PlayItem {
        
        let playItem = PlayItem(context: context)
        playItem.title = title
        playItem.thumbnail = UIImagePNGRepresentation(thumbnail)! as NSData
        playItem.duration = duration
        playItem.showname = showname
        playItem.publishedDate = publishedDate as NSDate
        playItem.playHead = playHead
        playItem.desc = desc
        playItem.fileName = fileName
        
        return playItem
    }
    
    

}
