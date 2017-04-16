//
//  MTModalControllerDelegate.swift
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

let MTModalControllerTransitionDelegateAssociationKey = "MTModalControllerTransitionDelegateAssociationKey"

public class MTModalControllerDelegate: NSObject {

    /**
     Pan gesture for interactive presentation, Not supported yet.
     */
    @IBOutlet weak var panGestureForPresentation: UIPanGestureRecognizer? {
        didSet {
            panGestureForPresentation?.addTarget(self, action: #selector(panGestureForPresentationDidPan(_:)))
        }
    }

    /**
     Pan gesture for interactive dismissal.
     */
    @IBOutlet weak var panGestureForDismissal: UIPanGestureRecognizer? {
        didSet {
            panGestureForDismissal?.addTarget(self, action: #selector(panGestureForDismissalDidPan(_:)))
        }
    }
    
    /**
     Source view controller for interactive presentation, Not supported yet.
     */
    @IBOutlet weak var sourceController:UIViewController?
    
    /**
     Destination view controller.
     */
    @IBOutlet weak var destinationController:UIViewController? {
        didSet {
            objc_setAssociatedObject(destinationController, UnsafeRawPointer.init(MTModalControllerTransitionDelegateAssociationKey), self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            destinationController?.transitioningDelegate = self
            
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
     Transition subType (enum) as transition direction, default value is set to direction left to right for Dismissal and right to left for Presentation.
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
     Gesture dismissal direction (enum), default value is set to direction left to right.
     */
    @IBInspectable var gestureDismissalDirection:MTGestureDirection = .LeftToRight
    
    
    /**
     Transition duration (in seconds), default value is set to 2 seconds.
     */
    @IBInspectable var duration: Double = 2
    
    var transitionType: MTTransitionType = .Push2
    var oppsiteSubType: MTTransitionSubType = .LeftToRight
    var transitionSubType: MTTransitionSubType = .RightToLeft {
        willSet(newTransitionSubType) {
            oppsiteSubType = oppsiteTransition(subType: newTransitionSubType)
        }
    }
    
    override init() {
        
        super.init()
        
    }
    
    
    init(destinationController:UIViewController,transitionType: MTTransitionType) {
        self.destinationController = destinationController
        self.transitionType = transitionType
        super.init()
        destinationController.transitioningDelegate = self
        destinationController.modalPresentationStyle = .fullScreen
        objc_setAssociatedObject(destinationController, UnsafeRawPointer.init(MTModalControllerTransitionDelegateAssociationKey), self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
    }
    
    deinit {
        print("modal delegate has been deinit")
    }
    
    func addInteractiveTo(sourceController:UIViewController,panGesture: UIPanGestureRecognizer?) {
        self.sourceController = sourceController
        var gesture = panGesture
        if gesture == nil {
            gesture = UIPanGestureRecognizer()
            gesture?.delegate = self
            gesture?.maximumNumberOfTouches = 1
        }
        gesture?.addTarget(self, action: #selector(panGestureForPresentationDidPan(_:)))
        sourceController.view.addGestureRecognizer(gesture!)
        panGestureForPresentation = gesture
        
    }
    
    func addInteractiveToDestinationController(panGesture: UIPanGestureRecognizer?) {
        var gesture = panGesture
        if gesture == nil {
            gesture = UIPanGestureRecognizer()
            gesture?.delegate = self
            gesture?.maximumNumberOfTouches = 1
        }
        gesture?.addTarget(self, action: #selector(panGestureForDismissalDidPan(_:)))
        destinationController?.view.addGestureRecognizer(gesture!)
        panGestureForDismissal = gesture
        
    }
  
    func removeGestureForDismissalRecognizer() {
        //
    }
    
    func panGestureForPresentationDidPan(_ gesture: UIPanGestureRecognizer) {
        
        if ((sourceController?.transitionCoordinator) != nil) {
            return
        }
        
        if gesture.state == .began || gesture.state == .changed {
            beginInteractivePresentationTransitionIfPossible(gesture: gesture)
        }
    }
    
    func panGestureForDismissalDidPan(_ gesture: UIPanGestureRecognizer) {
        
        if ((destinationController?.transitionCoordinator) != nil) {
            return
        }
        
        if gesture.state == .began || gesture.state == .changed {
            beginInteractiveDismissalTransitionIfPossible(gesture: gesture)
        }
        
    }
    
    func beginInteractivePresentationTransitionIfPossible(gesture: UIPanGestureRecognizer) {
        
        let translation: CGPoint = gesture.translation(in: sourceController?.view)
        guard let toController = destinationController else { return }
        
        if gestureDismissalDirection == .LeftToRight && translation.x < 0.0 {
            
            let _ = sourceController?.present(toController, animated: true, completion: nil)
            
        } else if gestureDismissalDirection == .RightToLeft && translation.x > 0.0 {
            
            let _ = sourceController?.present(toController, animated: true, completion: nil)
            
        } else if gestureDismissalDirection == .TopToBottom && translation.y < 0.0 {
            
            let _ = sourceController?.present(toController, animated: true, completion: nil)
            
        } else if gestureDismissalDirection == .BottomToTop && translation.y > 0.0 {
            
            let _ = sourceController?.present(toController, animated: true, completion: nil)
            
        } else {
            if !translation.equalTo(CGPoint.zero) {
                gesture.isEnabled = false
                gesture.isEnabled = true
            }
        }
        
        destinationController?.transitionCoordinator?.animate(alongsideTransition: nil, completion: { [unowned self] (context) in
            if context.isCancelled && gesture.state == .changed {
                self.beginInteractivePresentationTransitionIfPossible(gesture: gesture)
            }
        })
        
    }
    
    func beginInteractiveDismissalTransitionIfPossible(gesture: UIPanGestureRecognizer) {
        
        let translation: CGPoint = gesture.translation(in: destinationController?.view)
        guard let presentingController = destinationController?.presentingViewController else { return }
        
        if gestureDismissalDirection == .LeftToRight && translation.x > 0.0 {
            
            presentingController.dismiss(animated: true, completion: nil)
            
        } else if gestureDismissalDirection == .RightToLeft && translation.x < 0.0 {
            
            presentingController.dismiss(animated: true, completion: nil)
            
        } else if gestureDismissalDirection == .TopToBottom && translation.y > 0.0 {
            
            presentingController.dismiss(animated: true, completion: nil)
            
        } else if gestureDismissalDirection == .BottomToTop && translation.y < 0.0 {
            
            presentingController.dismiss(animated: true, completion: nil)
            
        } else {
            if !translation.equalTo(CGPoint.zero) {
                gesture.isEnabled = false
                gesture.isEnabled = true
            }
        }
        
        destinationController?.transitionCoordinator?.animate(alongsideTransition: nil, completion: { [unowned self] (context) in
            if context.isCancelled && gesture.state == .changed {
                self.beginInteractivePresentationTransitionIfPossible(gesture: gesture)
            }
        })
    }
    
    func oppsiteTransition(subType: MTTransitionSubType) -> MTTransitionSubType {
        switch (subType) {
        case .LeftToRight:
            gestureDismissalDirection = .RightToLeft
            return .RightToLeft
        case .RightToLeft:
            gestureDismissalDirection = .LeftToRight
            return .LeftToRight
        case .TopToBottom:
            gestureDismissalDirection = .BottomToTop
            return .BottomToTop
        case .BottomToTop:
            gestureDismissalDirection = .TopToBottom
            return .TopToBottom
        case .Horizontal:
            gestureDismissalDirection = .LeftToRight
            return subType
        case .HorizontalOpposite:
            gestureDismissalDirection = .LeftToRight;
            return subType
        case .Vertical:
            gestureDismissalDirection = .TopToBottom
            return subType
        case .VerticalOpposite:
            gestureDismissalDirection = .TopToBottom
            return subType
        default:
            gestureDismissalDirection = .LeftToRight
            return .LeftToRight
        }
    }
    
}

extension MTModalControllerDelegate : UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

extension MTModalControllerDelegate : UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return MTAnimatedInteractiveTransitioning.init(transitionType: transitionType, transitionSubType: transitionSubType, duration: duration, panGestureRecognizer: nil, gestureDirection: nil)
        
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return MTAnimatedInteractiveTransitioning.init(transitionType: transitionType, transitionSubType: oppsiteSubType, duration: duration, panGestureRecognizer: nil, gestureDirection: nil)
    }
    
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        guard let gesture = panGestureForPresentation, gesture.state == .began || gesture.state == .changed else { return nil}
        
        let animatedInteractiveTransitioning = animator as! MTAnimatedInteractiveTransitioning
        animatedInteractiveTransitioning.gestureDirection = gestureDismissalDirection
        animatedInteractiveTransitioning.panGestureRecognizer = gesture
        
        return animatedInteractiveTransitioning
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        guard let gesture = panGestureForDismissal, gesture.state == .began || gesture.state == .changed else { return nil}
        
        let animatedInteractiveTransitioning = animator as! MTAnimatedInteractiveTransitioning
        animatedInteractiveTransitioning.gestureDirection = gestureDismissalDirection
        animatedInteractiveTransitioning.panGestureRecognizer = gesture
        
        return animatedInteractiveTransitioning
        
    }
    
}

