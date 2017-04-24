//
//  NavigationFirstViewController.swift
//  MasterTransitions
//
//  Created by Home on 4/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import MasterTransitions

class NavigationFirstViewController: UIViewController {

    var transitionType: MTTransitionType = .Push2    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = true        
        
        guard let navigationController = self.navigationController else {
            return
        }
        let navigationControllerDelegate = MTNavigationControllerDelegate.init(navigationController: navigationController, transitionType: transitionType, isInteractive: true)
        navigationControllerDelegate.duration = 1.4
        navigationControllerDelegate.transitionSubType = .RightToLeft
        navigationControllerDelegate.transitionBackgroundColor = .black
        
    }

    @IBAction func back(_ sender: Any) {
        self.navigationController?.delegate = nil        
        let _ = self.navigationController?.popViewController(animated: true)
        
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
