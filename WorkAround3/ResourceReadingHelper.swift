//
//  ResourceReadingHelper.swift
//  WorkAround3
//
//  Created by SeoGiwon on 24/09/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit
import CoreData

class ResourceReadingHelper {
    
    static func playItemDictArray() -> [[String: Any]]? {
        let path = Bundle.main.path(forResource: "playItems", ofType: "json")
        
        guard let contentsString = try? String(contentsOfFile: path!),
            let contentsInDataType = contentsString.data(using: .utf8) else {
            print("couldn't find contents")
            return nil
        }
        
        guard let jsonAnyResult = try? JSONSerialization.jsonObject(with: contentsInDataType, options: []),
            let jsonDict = jsonAnyResult as? [String: Any] else {
            print("couldn't serialize")
            return nil
        }
        
        return jsonDict["sample_mp3s"] as? [[String:AnyObject]]
    }
    
    /*
    static func readPlayItemJsonFile(context: NSManagedObjectContext) -> [PlayItem]? {
        let path = Bundle.main.path(forResource: "playItems", ofType: "json")
        
        do {
            let contents = try String(contentsOfFile: path!)
            print(contents)
        } catch {
            // contents could not be loaded
        }
        
        guard let contents = try? String(contentsOfFile: path!),
            let dict = ResourceReadingHelper.convertToDictionary(text: contents),
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
        
        for (i,v) in array.enumerated() {
            
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
            
            let playItem = PlayItem.playItem(context: context, title: title, thumbnail: thumbnailImage, duration: duration.doubleValue, showname: showName, publishedDate: date, playHead: 0.0, desc: description, fileName: fileName)
            playItem.id = Int16(i)
            
            playItems.append(playItem)
        }
        
        return playItems
    }
    */
}
