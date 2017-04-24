//
//  NavigationFirstViewController.swift
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
