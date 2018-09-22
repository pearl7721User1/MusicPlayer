//
//  WorkAround3Tests.swift
//  WorkAround3Tests
//
//  Created by SeoGiwon on 21/09/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import XCTest


@testable import WorkAround3

class WorkAround3Tests: XCTestCase {
    
    
    
    func testLoadingSampleData() {
        let playItems = PlayItem.samplePlayItems()
        
        for (i,v) in playItems.enumerated() {
            
            print(v.description)
            
        }
    }
    
    
}
