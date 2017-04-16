//
//  MTPullTransition1.swift
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

class MTPullTransition1: MTTransitionAnimator {
    
    override func setupTranisition(containerView: UIView, fromView: UIView, toView: UIView, fromViewFrame: CGRect, toViewFrame: CGRect) {
        
        var fromFrame: CGRect = CGRect.zero
        var toFrame: CGRect = CGRect.zero
        
        switch transitionSubType {
            
        case .RightToLeft:
            fromFrame = fromViewFrame.offsetBy(dx: -(fromViewFrame.width), dy: 0)
            toFrame = toViewFrame.offsetBy(dx: toViewFrame.width, dy: 0)
            
        case .LeftToRight:
            fromFrame = fromViewFrame.offsetBy(dx: fromViewFrame.width, dy: 0)
            toFrame = toViewFrame.offsetBy(dx: -(toViewFrame.width), dy: 0)
            
        case .TopToBottom:
            fromFrame = fromViewFrame.offsetBy(dx: 0, dy: fromViewFrame.height)
            toFrame = toViewFrame.offsetBy(dx: 0, dy: -(toViewFrame.height))
        case .BottomToTop:
            fromFrame = fromViewFrame.offsetBy(dx: 0, dy: -(fromViewFrame.height))
            toFrame = toViewFrame.offsetBy(dx: 0, dy: toViewFrame.height)
            
        default:
            fromFrame = fromViewFrame.offsetBy(dx: -(fromViewFrame.width), dy: 0)
            toFrame = toViewFrame.offsetBy(dx: toViewFrame.width, dy: 0)
        }
        
        fromView.frame = fromViewFrame
        toView.frame = toFrame
        containerView.addSubview(toView)
        containerView.backgroundColor = UIColor.lightGray
        
        let animator: UIViewPropertyAnimator = UIViewPropertyAnimator.init(duration: duration, curve: .linear, animations: {
            fromView.frame = fromFrame
            toView.frame = toViewFrame
            
            UIView.animateKeyframes(withDuration: self.duration, delay: 0, options: .calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.15, animations: {
                    toView.transform = CGAffineTransform.init(rotationAngle: 0.1)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.15, relativeDuration: 0.15, animations: {
                    toView.transform = CGAffineTransform.init(rotationAngle: -0.1)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.30, relativeDuration: 0.15, animations: {
                    toView.transform = CGAffineTransform.init(rotationAngle: 0.1)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.45, relativeDuration: 0.15, animations: {
                    toView.transform = CGAffineTransform.init(rotationAngle: -0.1)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.60, relativeDuration: 0.15, animations: {
                    toView.transform = CGAffineTransform.init(rotationAngle: 0.1)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.15, animations: {
                    toView.transform = CGAffineTransform.init(rotationAngle: -0.1)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.90, relativeDuration: 0.10, animations: {
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
