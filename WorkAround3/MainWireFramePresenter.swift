//
//  MainWireFramePresenter.swift
//  WorkAround3
//
//  Created by SeoGiwon on 18/03/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit

class MainWireFramePresenter {
    
    weak var wireFrame: MainWireFrame!
//    var interactor: MomentsInteractor!
    
    
    func presentAudioPlayViewController(from presentationContext: UIViewController) {
        
        presentationContext.present(wireFrame.audioPlayerViewController, animated: true, completion: nil)
        
    }
    
}
