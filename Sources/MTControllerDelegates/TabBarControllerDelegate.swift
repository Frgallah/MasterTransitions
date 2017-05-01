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

let TabBarControllerTransitionDelegateAssociationKey = "TabBarControllerTransitionDelegateAssociationKey"

public class TabBarControllerDelegate: NSObject {
    
    /**
     TabBar view controller.
     */
    @IBOutlet public weak var tabBarController:UITabBarController? {
        didSet {
            objc_setAssociatedObject(tabBarController, UnsafeRawPointer.init(TabBarControllerTransitionDelegateAssociationKey), self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            tabBarController?.delegate = self
            
            if isInteractive {
                configurePanGestureRecognizer()
            }
        }
    }
    
    /**
     Transition Type (enum), default value is set to Push2.
     */
    @IBInspectable public var type: UInt = 0 {
        willSet(newType) {
            if newType < UInt(TransitionType.Max.rawValue) {
                transitionType = TransitionType(rawValue: Int(newType))!
            } else {
                transitionType = TransitionType.Push2
            }
        }
    }
    
    /**
     Transition subType (enum) as transition direction, default value is set to direction left to right for left tab and right to left for right tab.
     */
    @IBInspectable public var subType: UInt = 0 {
        willSet(newSubType) {
            if newSubType < UInt(TransitionSubType.None.rawValue) {
                transitionSubType = TransitionSubType(rawValue: Int(newSubType))!
            } else {
                transitionSubType = TransitionSubType.RightToLeft
            }
        }
    }
    
    /**
     Transition duration (in seconds), default value is set to 2 seconds.
     */
    @IBInspectable public var duration: Double = 2.0
    
    /**
     If is Interactive is true it will  make the transition interactive by adding pan gesture to tabBar controller view.
     */
    @IBInspectable public var isInteractive: Bool = false {
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
    
    public var transitionType: TransitionType = .Push2
    var oppsiteSubType: TransitionSubType = .LeftToRight
    public var transitionSubType:TransitionSubType = .RightToLeft {
        willSet(newTransitionSubType) {
            oppsiteSubType = oppsiteTransition(subType: newTransitionSubType)
        }
    }
    
    public var transitionBackgroundColor: UIColor = UIColor.black    
    fileprivate var panGestureRecognizer: UIPanGestureRecognizer?
    fileprivate var gestureDirection: GestureDirection = .LeftToRight
    
    public override init() {
        super.init()
    }
    
    public init(tabBarController: UITabBarController, transitionType: TransitionType, isInteractive: Bool) {
        self.tabBarController = tabBarController
        self.transitionType = transitionType
        self.isInteractive = isInteractive
        super.init()
        tabBarController.delegate = self
        objc_setAssociatedObject(tabBarController, UnsafeRawPointer.init(TabBarControllerTransitionDelegateAssociationKey), self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        if isInteractive {
            configurePanGestureRecognizer()
        }
        
    }
    
    deinit {
        NSLog(" tabBar delegate has been deinit ")
    }
    
    private func configurePanGestureRecognizer() {
        panGestureRecognizer = UIPanGestureRecognizer()
        panGestureRecognizer?.delegate = self
        panGestureRecognizer?.maximumNumberOfTouches = 1
        panGestureRecognizer?.addTarget(self, action: #selector(panGestureRecognizerDidPan(_:)))
        tabBarController?.view.addGestureRecognizer(panGestureRecognizer!)
        
    }
    
    private func removeGestureRecognizer() {
        //
    }
    
    @objc private func panGestureRecognizerDidPan(_ gesture: UIPanGestureRecognizer) {
        
        if ((tabBarController?.transitionCoordinator) != nil) {
            return
        }
        
        if gesture.state == .began || gesture.state == .changed {
            beginInteractiveTransitionIfPossible(gesture: gesture)
        }
    }
    
    private func beginInteractiveTransitionIfPossible(gesture: UIPanGestureRecognizer) {
        
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
    
    fileprivate func oppsiteTransition(subType: TransitionSubType) -> TransitionSubType {
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

extension TabBarControllerDelegate : UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

extension TabBarControllerDelegate : UITabBarControllerDelegate {
    
    public func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        var subType = transitionSubType
        let controllers = tabBarController.viewControllers
        if (controllers?.index(of: toVC))! < (controllers?.index(of: fromVC))! {
            subType = oppsiteSubType
        }
        return AnimatedInteractiveTransitioning.init(transitionType: transitionType, transitionSubType: subType, duration: duration, panGestureRecognizer: nil, gestureDirection: nil, backgroundColor: transitionBackgroundColor)
        
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let gesture = panGestureRecognizer, gesture.state == .began || gesture.state == .changed else {
            return nil
        }
        
        let animatedInteractiveTransitioning = animationController as! AnimatedInteractiveTransitioning
        animatedInteractiveTransitioning.gestureDirection = gestureDirection
        animatedInteractiveTransitioning.panGestureRecognizer = panGestureRecognizer
        
        return animatedInteractiveTransitioning
        
    }
    
    
}
