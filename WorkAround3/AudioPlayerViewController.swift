//
//  PlayViewController.swift
//  WorkAround3
//
//  Created by SeoGiwon on 21/02/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit

class AudioPlayerViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
 
        
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: self.view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 30.0, height: 30.0))
        maskLayer.path = path.cgPath
        view.layer.mask = maskLayer
 
 
        
        /*
        let newView = UIView()
        newView.backgroundColor = UIColor.red
        newView.frame = self.view.bounds
        
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: newView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 30.0, height: 30.0))
        maskLayer.path = path.cgPath
        newView.layer.mask = maskLayer
        
        self.view.addSubview(newView)
 */
    }
    /*
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: self.view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 30.0, height: 30.0))
        maskLayer.path = path.cgPath
        view.layer.mask = maskLayer
    }
    */
    @IBAction func btnTapped(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell

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
