//
//  MTAnimatedInteractiveTransitioning.swift
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

enum MTGestureDirection: Int {
    case Default
    case LeftToRight
    case RightToLeft
    case TopToBottom
    case BottomToTop
}



class MTAnimatedInteractiveTransitioning: NSObject {
    fileprivate var initiallyInteractive = false
    private let transitionType: MTTransitionType
    private let transitionSubType: MTTransitionSubType
    fileprivate var duration: TimeInterval = 0
    var panGestureRecognizer: UIPanGestureRecognizer? {
        didSet {
            panGestureRecognizer?.addTarget(self, action: #selector(updateInteractionFor(gesture:)))
            initiallyInteractive = true
        }
    }
    var transitionBackgroundColor: UIColor = UIColor.black {
        willSet {
            transition.backgroundColor = newValue
        }
    }
    var gestureDirection: MTGestureDirection?
    fileprivate var context: UIViewControllerContextTransitioning?
    var transition: MTTransitionAnimator!
    fileprivate var initialTranslation =  CGPoint.zero
    private var lastPercentage: CGFloat = 0
    
    init(transitionType: MTTransitionType,  transitionSubType:MTTransitionSubType, duration:TimeInterval, panGestureRecognizer:UIPanGestureRecognizer?, gestureDirection:MTGestureDirection?, backgroundColor: UIColor?) {
        self.transitionType = transitionType
        self.transitionSubType = transitionSubType
        self.gestureDirection = gestureDirection;
        if let color = backgroundColor {
            self.transitionBackgroundColor = color
        }
        
        
        super.init()
        transition = MTTransitionLoader.transitionForType(transitionType: transitionType, transitionSubType: transitionSubType)
        self.transition.duration = duration > 0 ? duration : self.transition.defaultDuration
        self.duration = transition.duration
        
        if let gesture = panGestureRecognizer {
            gesture.addTarget(self, action: #selector(updateInteractionFor(gesture:)))
            self.panGestureRecognizer = gesture
            self.initiallyInteractive = true
            
        }
        
    }
    
    deinit {
        NSLog(" AnimatedInteractiveTransitioning has been deinit ")
    }
    
    func updateInteractionFor(gesture: UIPanGestureRecognizer)
    {
        switch gesture.state {
        case .began: break
            
        case .changed:
            let percentage = percentFor(gesture: gesture)
            if percentage < 0.0 {
                context?.cancelInteractiveTransition()
                panGestureRecognizer?.removeTarget(self, action: #selector(updateInteractionFor(gesture:)))
                
            } else {
                transition.fractionComplete = percentage
                context?.updateInteractiveTransition(percentage)
                
            }
            
        case .ended:
            lastPercentage = 0
            endInteraction()
            
        default:
            context?.cancelInteractiveTransition()
        }
        
        
    }
    
    func percentFor(gesture: UIPanGestureRecognizer) -> CGFloat {
        
        guard let containerView = context?.containerView else {
            return lastPercentage
        }
        let translation: CGPoint = gesture.translation(in: containerView)
        var percentage:CGFloat = 0.0
        if gestureDirection == .LeftToRight && translation.x > 0.0 {
            if initialTranslation.x < 0.0 {
                percentage = -1.0
            } else {
                percentage = translation.x/(containerView.bounds.width)
            }
        } else if gestureDirection == .RightToLeft && translation.x < 0.0 {
            if initialTranslation.x > 0.0 {
                percentage = -1.0
            } else {
                percentage = -1.0 * (translation.x/(containerView.bounds.width))
            }
        } else if gestureDirection == .TopToBottom && translation.y > 0.0 {
            if initialTranslation.y < 0.0 {
                percentage = -1.0
            } else {
                percentage = translation.y/(containerView.bounds.height)
            }
        } else if gestureDirection == .BottomToTop && translation.y < 0.0 {
            if initialTranslation.y > 0.0 {
                percentage = -1.0
            } else {
                percentage = -1.0 * (translation.y/(containerView.bounds.height))
            }
        }
        lastPercentage = percentage
        return percentage
    }
    
    func completionPosition() -> UIViewAnimatingPosition {
        if transition.fractionComplete < transition.midDuration {
            return .start;
        } else {
            return .end;
        }
    }
    
    func endInteraction() {
        
        guard let transitiContext = context , transitiContext.isInteractive else { return }
        let position = completionPosition()
        if position == .end {
            transitiContext.finishInteractiveTransition()
        } else {
            transitiContext.cancelInteractiveTransition()
        }
       
        transition.animateTo(position: position, isResume: true)
        
    }
    
    func transitionAnimator() -> MTTransitionAnimator {
        if transition == nil {
            return MTTransitionLoader.transitionForType(transitionType: transitionType, transitionSubType: transitionSubType)
            
        } else {
            return transition
        }
    }
    
    
}

extension MTAnimatedInteractiveTransitioning : UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        transition.setupTranisition(transitionContext: transitionContext, transitionCompletion: {
            (completed) in
            transitionContext.completeTransition(completed)
        })
        transition.animateTo(position: .end, isResume: false)

    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        transition = nil
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        if transition.propertyAnimator != nil {
            return transition.propertyAnimator!
        } else {
            return interruptibleAnimator(using: transitionContext, transitionCompletion: {
                (completed) in
                transitionContext.completeTransition(completed)
            })
        
        }
        
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning, transitionCompletion: @escaping (Bool) -> ()) -> UIViewImplicitlyAnimating {
        
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView
        var fromView: UIView!
        var toView: UIView!
        
        if transitionContext.responds(to:#selector(transitionContext.view(forKey:))) {
            fromView = transitionContext.view(forKey: .from)
            toView = transitionContext.view(forKey: .to)
        } else {
            fromView = fromViewController?.view
            toView = toViewController?.view
        }
        
        let fromViewFrame = transitionContext.initialFrame(for: fromViewController!)
        let toViewFrame = transitionContext.finalFrame(for: toViewController!)
        fromView.frame = fromViewFrame
        toView.frame = toViewFrame
        containerView.addSubview(toView)
        toView.alpha = 0
        
        let animator: UIViewPropertyAnimator = UIViewPropertyAnimator.init(duration: duration, curve: .linear, animations: {
            
            fromView.alpha = 0
            toView.alpha = 1
            
        })
        
        animator.addCompletion({ (position) in
            
            let completed = position == .end
            transitionCompletion(completed)
            
        })
        
        animator.isUserInteractionEnabled = false
        
        return animator
    
    }
    
    
}

extension MTAnimatedInteractiveTransitioning : UIViewControllerInteractiveTransitioning {
    
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
     
        context = transitionContext
        initialTranslation = (panGestureRecognizer?.translation(in: transitionContext.containerView))!
        transition.isInteractive = true
        transition.setupTranisition(transitionContext: transitionContext, transitionCompletion: { (completed) in
            transitionContext.completeTransition(completed)
        })
   
    }
    
    var wantsInteractiveStart: Bool {
 
        return initiallyInteractive
    }
    
}

