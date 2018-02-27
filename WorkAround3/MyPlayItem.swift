//
//  MyPlayItem.swift
//  WorkAround3
//
//  Created by SeoGiwon on 21/02/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit

struct MyPlayItem {
    
    var urlStr: String
    var title: String
    
    static func playList() -> [MyPlayItem] {
        
        let item1 = MyPlayItem(urlStr: "http://traffic.libsyn.com/allearsenglish/AEE_900_Should_You_Use_Idioms_in_Natural_Conversations_Even_If_It_Feels_Awkward.mp3", title: "Feels Awkward")
        let item2 = MyPlayItem(urlStr: "http://traffic.libsyn.com/allearsenglish/AEE_899_Dont_Get_in_a_Tizzy_About_Phrasal_Verbs.mp3", title: "Tizzy About Phrasal Verbs")
        let item3 = MyPlayItem(urlStr: "http://traffic.libsyn.com/allearsenglish/AEE_898_4_Steps_to_Natural_English_Pronunciation_with_Rachel.mp3", title: "4 Steps to Natural")
        
        return [item1, item2, item3]
    }
}
