//
//  HomeViewController.swift
//  MasterTransitions
//
//  Created by Home on 4/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationController = segue.destination as! TransitionsTableViewController
        if segue.identifier == "navController" {
            destinationController.controllerType = .navigation
        } else if segue.identifier == "tabController" {
            destinationController.controllerType = .tabBar
        } else if segue.identifier == "modController" {
            destinationController.controllerType = .modal
        }
    }


}
