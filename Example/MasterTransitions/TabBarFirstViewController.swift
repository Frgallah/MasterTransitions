//
//  TabBarFirstViewController.swift
//  MasterTransitions
//
//  Created by Home on 4/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import MasterTransitions

class TabBarFirstViewController: UIViewController {

    var transitionType: MTTransitionType = .Push2    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        guard let tabBarController = self.tabBarController else {
            return
        }
        
        let tabBarControllerDelegate = MTTabBarControllerDelegate.init(tabBarController: tabBarController, transitionType: transitionType, isInteractive: true)
        tabBarControllerDelegate.duration = 2
        tabBarControllerDelegate.transitionSubType = .LeftToRight
        tabBarControllerDelegate.transitionBackgroundColor = .black
   
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
