//
//  TabBarFirstViewController.swift
//  MasterTransitions
//
//  Created by Frgallah on 4/11/17.
//
//  Copyright (c) 2017 Mohammed Frgallah. All rights reserved.
//
//  Licensed under the MIT license, can be found at:  https://github.com/Frgallah/MasterTransitions/blob/master/LICENSE  or  https://opensource.org/licenses/MIT
//

//  For last updated version of this code check the github page at https://github.com/Frgallah/MasterTransitions
//
//

import UIKit
import MasterTransitions

class TabBarFirstViewController: UIViewController {

    var transitionType: TransitionType = .Push2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        guard let tabBarController = self.tabBarController else {
            return
        }
        
        let tabBarControllerDelegate = TabBarControllerDelegate.init(tabBarController: tabBarController, transitionType: transitionType, isInteractive: true)
        tabBarControllerDelegate.duration = 0.6
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
