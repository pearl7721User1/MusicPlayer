//
//  MiniPlayBarController.swift
//  WorkAround3
//
//  Created by SeoGiwon on 19/12/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit

class MiniPlayBarController: NSObject {

    private var hostingView: UIView!
    private var bottomInset: CGFloat = 0
    var miniPlayBar = MiniPlayBar(frame: CGRect.zero)
    
    init(hostingView: UIView, bottomInset:CGFloat) {
        self.hostingView = hostingView
        self.bottomInset = bottomInset
    }

    func showMiniPlayBarTop() {
        hostingView.addSubview(miniPlayBar)
        miniPlayBar.translatesAutoresizingMaskIntoConstraints = false
        miniPlayBar.leftAnchor.constraint(equalTo: hostingView.leftAnchor, constant: 0).isActive = true
        miniPlayBar.rightAnchor.constraint(equalTo: hostingView.rightAnchor, constant: 0).isActive = true
        miniPlayBar.bottomAnchor.constraint(equalTo: hostingView.bottomAnchor, constant: -bottomInset).isActive = true
        miniPlayBar.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
    }

}
