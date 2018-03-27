//
//  AudioPlayWireFrame.swift
//  WorkAround3
//
//  Created by SeoGiwon on 28/02/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit

class AudioPlayWireFrame {
    
    lazy var navigationController: UINavigationController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SecondTabNavigationController") as! UINavigationController
        
        return viewController
        
    }()
    
    var audioListViewController: AudioListViewController {
        return self.navigationController.viewControllers[0] as! AudioListViewController
    }
    
    
    func setWireFrameViewControllers() {
        
    }
}
