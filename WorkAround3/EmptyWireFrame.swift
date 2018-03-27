//
//  EmptyWireFrame.swift
//  WorkAround3
//
//  Created by SeoGiwon on 28/02/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit

class EmptyWireFrame {

    lazy var navigationController: UINavigationController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FirstTabNavigationController") as! UINavigationController
        
        return viewController
        
    }()
    
    var emptyViewController: UIViewController {
       
        return navigationController.viewControllers[0] as! UIViewController
    }
    
    func setWireFrameViewControllers() {
        
        
    }
}
