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
    @NSManaged public var duration: Float
    @NSManaged public var showname: String?
    @NSManaged public var publishedDate: NSDate?
    @NSManaged public var playHead: Float
    @NSManaged public var desc: String?


    static func samplePlayItems(context: NSManagedObjectContext) -> [PlayItem]? {
    
        let playItems = ResourceReadingHelper.readPlayItemJsonFile(context: context)
        return playItems
    }

    
    static func playItem(context: NSManagedObjectContext, title: String, thumbnail: UIImage, duration: CGFloat, showname: String, publishedDate: Date, playHead: CGFloat, desc: String) -> PlayItem {
        
        let playItem = PlayItem(context: context)
        playItem.title = title
        playItem.thumbnail = UIImagePNGRepresentation(thumbnail)! as NSData
        playItem.duration = Float(duration)
        playItem.showname = showname
        playItem.publishedDate = publishedDate as NSDate
        playItem.playHead = Float(playHead)
        playItem.desc = desc
        
        return playItem
    }
    
    

}
