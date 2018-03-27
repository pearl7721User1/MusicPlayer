//
//  MainTabBarController.swift
//  WorkAround3
//
//  Created by SeoGiwon on 28/02/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    var audioPlayWireFrame = AudioPlayWireFrame()
    var emptyWireFrame = EmptyWireFrame()
    
    func setWireFramesAndTabViewControllers() {
        audioPlayWireFrame.setWireFrameViewControllers()
        emptyWireFrame.setWireFrameViewControllers()
        
        self.viewControllers = [emptyWireFrame.navigationController, audioPlayWireFrame.navigationController]
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
