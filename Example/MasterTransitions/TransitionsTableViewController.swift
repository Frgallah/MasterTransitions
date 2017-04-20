//
//  TransitionsTableViewController.swift
//  MasterTransitions
//
//  Created by Home on 4/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import MasterTransitions

enum ControllerTybe: Int {
    case navigation
    case tabBar
    case modal
}


class TransitionsTableViewController: UITableViewController {
    
    var controllerType: ControllerTybe = .navigation
    
    private var transitions: [String] = Array()
    private var transitionType: MTTransitionType = .Push2
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
        transitions = ["Push 2","Pull 1","Swing Door","Door 2","Door 3","Door 4","Door 5","Folder 1","Book 1","Cube 1","Cube 2","Cube 3","Blinds 1","Blinds 2","Puzzle 1"]
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return transitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = transitions[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if index > -1 && index < MTTransitionType.Max.rawValue {
            transitionType = MTTransitionType.init(rawValue: index)!
        } else {
            transitionType = .Push2
        }
        
        switch controllerType {
        case .navigation:
            let navigationFirstController = storyboard?.instantiateViewController(withIdentifier: "NavigationFVC") as! NavigationFirstViewController
            navigationFirstController.transitionType = transitionType
            self.navigationController?.pushViewController(navigationFirstController, animated: true)
          
        case .tabBar:
            let tabBarController = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
            let tabBarFirstController = (tabBarController.viewControllers)?[0] as! TabBarFirstViewController
            tabBarFirstController.transitionType = transitionType
            self.navigationController?.pushViewController(tabBarController, animated: true)
            
        case .modal:
            let modalFirstController = storyboard?.instantiateViewController(withIdentifier: "ModalFVC") as! ModalFirstViewController
            modalFirstController.transitionType = transitionType
            self.navigationController?.pushViewController(modalFirstController, animated: true)

        }
  
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     

}
