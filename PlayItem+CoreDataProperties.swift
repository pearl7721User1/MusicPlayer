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


    static func samplePlayItems(context: NSManagedObjectContext) -> [PlayItem] {
     
        
        let path = Bundle.main.path(forResource: "playItems", ofType: "json")
        
        do {
            let contents = try String(contentsOfFile: path!)
            print(contents)
        } catch {
            // contents could not be loaded
        }
        
        guard let contents = try? String(contentsOfFile: path!),
            let dict = PlayItem.convertToDictionary(text: contents),
            let array = dict["sample_mp3s"] as? [[String:AnyObject]] else {
            return [PlayItem]()
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
        
        var playItems = [PlayItem]()
        
        for (_,v) in array.enumerated() {
            
            guard let showName = v["show_name"] as? String,
                let title = v["title"] as? String,
                let description = v["description"] as? String,
                let duration = v["duration"] as? NSNumber,
                let publishedDateString = v["published_date"] as? String,
                let thumbnailName = v["thumbnail_image_name_in_bundle"] as? String,
                let fileName = v["mp3_file_name_in_bundle"] as? String else {
                
                return [PlayItem]()
            }
            
            
            guard let thumbnailImage = UIImage(named: thumbnailName) else {
                return [PlayItem]()
            }
            
            var date: Date {
                let formatter = DateFormatter()
                formatter.dateFormat = "E, d MMM yyyy HH:mm:ss z"
                return formatter.date(from: publishedDateString)!
            }
            
            let playItem = PlayItem.playItem(context: context, title: title, thumbnail: thumbnailImage, duration: CGFloat(duration.floatValue), showname: showName, publishedDate: date, playHead: 0.0, desc: description)
            
            playItems.append(playItem)
        }
        
        return playItems
        
    }

    
    static private func playItem(context: NSManagedObjectContext, title: String, thumbnail: UIImage, duration: CGFloat, showname: String, publishedDate: Date, playHead: CGFloat, desc: String) -> PlayItem {
        
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
    
    static private func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

}
