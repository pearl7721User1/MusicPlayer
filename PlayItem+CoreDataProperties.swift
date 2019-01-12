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
    @NSManaged public var id: Int16


}
