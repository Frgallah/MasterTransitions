//
//  MTPushTransition2.swift
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

/* Transition's Directions as Transition SubType
 
 RightToLeft
 LeftToRight
 BottomToTop
 TopToBottom
 
 */


import UIKit

class PushTransition2: TransitionAnimator {
    
    override func setupTranisition(containerView: UIView, fromView: UIView, toView: UIView, fromViewFrame: CGRect, toViewFrame: CGRect) {
        
        var fromFrame: CGRect = CGRect.zero
        var toFrame: CGRect = CGRect.zero
        var toFrame1: CGRect = CGRect.zero
        var toFrame2: CGRect = CGRect.zero
        var toFrame3: CGRect = CGRect.zero
        
        switch transitionSubType {
        case .RightToLeft:
            fromFrame = fromViewFrame.offsetBy(dx: -(fromViewFrame.width), dy: 0)
            let width = toViewFrame.width
            toFrame = toViewFrame.offsetBy(dx: width, dy: 0)
            toFrame1 = toViewFrame.offsetBy(dx: (width * 0.03), dy: 0)
            toFrame2 = toViewFrame.offsetBy(dx: (width * 0.015), dy: 0)
            toFrame3 = toViewFrame.offsetBy(dx: (width * 0.01), dy: 0)
            
        case .LeftToRight:
            fromFrame = fromViewFrame.offsetBy(dx: fromViewFrame.width, dy: 0)
            let width = toViewFrame.width
            toFrame = toViewFrame.offsetBy(dx: -(width), dy: 0)
            toFrame1 = toViewFrame.offsetBy(dx: -(width * 0.03), dy: 0)
            toFrame2 = toViewFrame.offsetBy(dx: -(width * 0.015), dy: 0)
            toFrame3 = toViewFrame.offsetBy(dx: -(width * 0.01), dy: 0)
            
        case .TopToBottom:
            fromFrame = fromViewFrame.offsetBy(dx: 0, dy: fromViewFrame.height)
            let height = toViewFrame.height
            toFrame = toViewFrame.offsetBy(dx: 0, dy: -(height))
            toFrame1 = toViewFrame.offsetBy(dx: 0, dy: -(height * 0.03))
            toFrame2 = toViewFrame.offsetBy(dx: 0, dy: -(height * 0.015))
            toFrame3 = toViewFrame.offsetBy(dx: 0, dy: -(height * 0.01))
            
        case .BottomToTop:
            fromFrame = fromViewFrame.offsetBy(dx: 0, dy: -(fromViewFrame.height))
            let height = toViewFrame.height
            toFrame = toViewFrame.offsetBy(dx: 0, dy: (height))
            toFrame1 = toViewFrame.offsetBy(dx: 0, dy: (height * 0.03))
            toFrame2 = toViewFrame.offsetBy(dx: 0, dy: (height * 0.015))
            toFrame3 = toViewFrame.offsetBy(dx: 0, dy: (height * 0.01))
            
        default:
            fromFrame = fromViewFrame.offsetBy(dx: -(fromViewFrame.width), dy: 0)
            let width = toViewFrame.width
            toFrame = toViewFrame.offsetBy(dx: width, dy: 0)
            toFrame1 = toViewFrame.offsetBy(dx: (width * 0.03), dy: 0)
            toFrame2 = toViewFrame.offsetBy(dx: (width * 0.015), dy: 0)
            toFrame3 = toViewFrame.offsetBy(dx: (width * 0.01), dy: 0)
        }
        
        containerView.backgroundColor = UIColor.lightGray
        fromView.frame = fromViewFrame
        toView.frame = toFrame
        containerView.addSubview(toView)
        toView.alpha = 0
        
        let animator: UIViewPropertyAnimator = UIViewPropertyAnimator.init(duration: duration, curve: .linear, animations: {
            
            fromView.alpha = 0
            toView.alpha = 1
            
            UIView.animateKeyframes(withDuration: self.duration, delay: 0, options: .calculationModeLinear, animations: {
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.76, animations: {
                    fromView.frame = fromFrame
                    toView.frame = toViewFrame
                })
                UIView.addKeyframe(withRelativeStartTime: 0.76, relativeDuration: 0.06, animations: {
                    toView.frame = toFrame1
                    toView.transform = CGAffineTransform.init(rotationAngle: -0.008)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.82, relativeDuration: 0.06, animations: {
                    toView.frame = toViewFrame
                    toView.transform = CGAffineTransform.init(rotationAngle: 0.006)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.88, relativeDuration: 0.04, animations: {
                    toView.frame = toFrame2
                    toView.transform = CGAffineTransform.init(rotationAngle: -0.004)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.92, relativeDuration: 0.04, animations: {
                    toView.frame = toViewFrame
                    toView.transform = CGAffineTransform.init(rotationAngle: 0.002)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.96, relativeDuration: 0.02, animations: {
                    toView.frame = toFrame3
                    toView.transform = CGAffineTransform.init(rotationAngle: -0.0008)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.98, relativeDuration: 0.02, animations: {
                    toView.frame = toViewFrame
                    toView.transform = CGAffineTransform.init(rotationAngle: 0.0)
                })
                
            }, completion: nil)
            
            
        })
        
        animator.addCompletion({ [unowned self] (position) in
            
            if self.transitionCompletion != nil {
                let completed = position == .end
                self.transitionCompletion!(completed)
            }
            
        })
        
        animator.isUserInteractionEnabled = false
        propertyAnimator = animator
        
    }
    
}
