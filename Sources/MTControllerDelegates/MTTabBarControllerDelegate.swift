//
//  MTTabBarControllerDelegate.swift
//  Pods
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

let MTTabBarControllerTransitionDelegateAssociationKey = "MTTabBarControllerTransitionDelegateAssociationKey"

public class MTTabBarControllerDelegate: NSObject {
    
    /**
     TabBar view controller.
     */
    @IBOutlet weak var tabBarController:UITabBarController? {
        didSet {
            objc_setAssociatedObject(tabBarController, UnsafeRawPointer.init(MTTabBarControllerTransitionDelegateAssociationKey), self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            tabBarController?.delegate = self
            
            if isInteractive {
                configurePanGestureRecognizer()
            }
        }
    }
    
    /**
     Transition Type (enum), default value is set to Push2.
     */
    @IBInspectable var type: UInt = 0 {
        willSet(newType) {
            if newType < UInt(MTTransitionType.Max.rawValue) {
                transitionType = MTTransitionType(rawValue: Int(newType))!
            } else {
                transitionType = MTTransitionType.Push2
            }
        }
    }
    
    /**
     Transition subType (enum) as transition direction, default value is set to direction left to right for left tab and right to left for right tab.
     */
    @IBInspectable var subType: UInt = 0 {
        willSet(newSubType) {
            if newSubType < UInt(MTTransitionSubType.Max.rawValue) {
                transitionSubType = MTTransitionSubType(rawValue: Int(newSubType))!
            } else {
                transitionSubType = MTTransitionSubType.RightToLeft
            }
        }
    }
    
    /**
     Transition duration (in seconds), default value is set to 2 seconds.
     */
    @IBInspectable var duration: Double = 2.0
    
    /**
     If is Interactive is true it will  make the transition interactive by adding pan gesture to tabBar controller view.
     */
    @IBInspectable var isInteractive: Bool = false {
        willSet(newIsInteractive) {
            if tabBarController != nil {
                if newIsInteractive {
                    configurePanGestureRecognizer()
                } else {
                    removeGestureRecognizer()
                }
            }
        }
    }
    
    var transitionType: MTTransitionType = .Push2
    var oppsiteSubType: MTTransitionSubType = .LeftToRight
    var transitionSubType:MTTransitionSubType = .RightToLeft {
        willSet(newTransitionSubType) {
            oppsiteSubType = oppsiteTransition(subType: newTransitionSubType)
        }
    }
    fileprivate var panGestureRecognizer: UIPanGestureRecognizer?
    fileprivate var gestureDirection: MTGestureDirection = .LeftToRight
    
    override init() {
        super.init()
    }
    
    init(tabBarController: UITabBarController, transitionType: MTTransitionType, isInteractive: Bool) {
        self.tabBarController = tabBarController
        self.transitionType = transitionType
        self.isInteractive = isInteractive
        super.init()
        tabBarController.delegate = self
        objc_setAssociatedObject(tabBarController, UnsafeRawPointer.init(MTTabBarControllerTransitionDelegateAssociationKey), self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        if isInteractive {
            configurePanGestureRecognizer()
        }
        
    }
    
    deinit {
        NSLog(" tabBar delegate has been deinit ")
    }
    
    func configurePanGestureRecognizer() {
        panGestureRecognizer = UIPanGestureRecognizer()
        panGestureRecognizer?.delegate = self
        panGestureRecognizer?.maximumNumberOfTouches = 1
        panGestureRecognizer?.addTarget(self, action: #selector(panGestureRecognizerDidPan(_:)))
        tabBarController?.view.addGestureRecognizer(panGestureRecognizer!)
        
    }
    
    func removeGestureRecognizer() {
        //
    }
    
    func panGestureRecognizerDidPan(_ gesture: UIPanGestureRecognizer) {
        
        if ((tabBarController?.transitionCoordinator) != nil) {
            return
        }
        
        if gesture.state == .began || gesture.state == .changed {
            beginInteractiveTransitionIfPossible(gesture: gesture)
        }
    }
    
    func beginInteractiveTransitionIfPossible(gesture: UIPanGestureRecognizer) {
        
        let translation: CGPoint = gesture.translation(in: tabBarController!.view)
        if translation.x > 0.0 && (tabBarController?.selectedIndex)! > 0 {
            gestureDirection = .LeftToRight
            tabBarController?.selectedIndex -= 1
        } else if translation.x < 0.0 && (tabBarController?.selectedIndex)! + 1 < (tabBarController?.viewControllers?.count)!{
            gestureDirection = .RightToLeft
            tabBarController?.selectedIndex += 1
        } else {
            if !translation.equalTo(CGPoint.zero) {
                gesture.isEnabled = false
                gesture.isEnabled = true
            }
        }
        tabBarController?.transitionCoordinator?.animate(alongsideTransition: nil, completion: { [unowned self] (context) in
            if context.isCancelled && gesture.state == .changed {
                self.beginInteractiveTransitionIfPossible(gesture: gesture)
            }
        })
        
    }
    
    func oppsiteTransition(subType: MTTransitionSubType) -> MTTransitionSubType {
        switch (subType) {
        case .LeftToRight:
            return .RightToLeft
        case .RightToLeft:
            return .LeftToRight
        case .TopToBottom:
            return .BottomToTop
        case .BottomToTop:
            return .TopToBottom
        case .Horizontal,.HorizontalOpposite,.Vertical,.VerticalOpposite:
            return subType
        default:
            return .LeftToRight
        }
    }
    
}

extension MTTabBarControllerDelegate : UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

extension MTTabBarControllerDelegate : UITabBarControllerDelegate {
    
    public func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        var subType = transitionSubType
        let controllers = tabBarController.viewControllers
        if (controllers?.index(of: toVC))! < (controllers?.index(of: fromVC))! {
            subType = oppsiteSubType
        }
        return MTAnimatedInteractiveTransitioning.init(transitionType: transitionType, transitionSubType: subType, duration: duration, panGestureRecognizer: nil, gestureDirection: nil)
        
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let gesture = panGestureRecognizer, gesture.state == .began || gesture.state == .changed else {
            return nil
        }
        
        let animatedInteractiveTransitioning = animationController as! MTAnimatedInteractiveTransitioning
        animatedInteractiveTransitioning.gestureDirection = gestureDirection
        animatedInteractiveTransitioning.panGestureRecognizer = panGestureRecognizer
        
        return animatedInteractiveTransitioning
        
    }
    
    
}
