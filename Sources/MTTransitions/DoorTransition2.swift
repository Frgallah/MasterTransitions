//
//  MTDoorTransition2.swift
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
 
 Horizontal
 Vertical
 
 */


import UIKit

class DoorTransition2: TransitionAnimator {
    
    override func setupTranisition(containerView: UIView, fromView: UIView, toView: UIView, fromViewFrame: CGRect, toViewFrame: CGRect) {
        
        fromView.frame = fromViewFrame
        toView.frame = toViewFrame
        containerView.addSubview(toView)
        var fromFrame1: CGRect = fromViewFrame
        var fromFrame2: CGRect = fromViewFrame
        var center1 = CGPoint.zero
        var center2 = CGPoint.zero
        
        switch transitionSubType {
            
        case .Horizontal:
            
            fromFrame1 = CGRect(x: fromViewFrame.origin.x, y: fromViewFrame.origin.y, width: fromViewFrame.width/2.0, height: fromViewFrame.height)
            fromFrame2 = CGRect(x: fromViewFrame.origin.x + fromViewFrame.width/2.0, y: fromViewFrame.origin.y, width: fromViewFrame.width/2.0, height: fromViewFrame.height)
            center1 = CGPoint(x: fromFrame1.midX - fromFrame1.width, y: fromFrame1.midY)
            center2 = CGPoint(x: fromFrame2.midX + fromFrame2.width, y: fromFrame2.midY)
            
        case .Vertical:
            
            fromFrame1 = CGRect(x: fromViewFrame.origin.x, y: fromViewFrame.origin.y, width: fromViewFrame.width, height: fromViewFrame.height/2.0)
            fromFrame2 = CGRect(x: fromViewFrame.origin.x, y: fromViewFrame.origin.y + fromViewFrame.height/2.0, width: fromViewFrame.width, height: fromViewFrame.height/2.0)
            center1 = CGPoint(x: fromFrame1.midX, y: fromFrame1.midY - fromFrame1.height)
            center2 = CGPoint(x: fromFrame2.midX, y: fromFrame2.midY + fromFrame2.height)
            
        default:
            
            fromFrame1 = CGRect(x: fromViewFrame.origin.x, y: fromViewFrame.origin.y, width: fromViewFrame.width/2.0, height: fromViewFrame.height)
            fromFrame2 = CGRect(x: fromViewFrame.origin.x + fromViewFrame.width/2.0, y: fromViewFrame.origin.y, width: fromViewFrame.width/2.0, height: fromViewFrame.height)
            center1 = CGPoint(x: fromFrame1.midX - fromFrame1.width, y: fromFrame1.midY)
            center2 = CGPoint(x: fromFrame2.midX + fromFrame2.width, y: fromFrame2.midY)
            
        }
        
        guard let view1 = fromView.resizableSnapshotView(from: fromFrame1, afterScreenUpdates: false, withCapInsets: UIEdgeInsets.zero) , let view2 = fromView.resizableSnapshotView(from: fromFrame2, afterScreenUpdates: false, withCapInsets: UIEdgeInsets.zero)
            
            else {
                
                let animator: UIViewPropertyAnimator = UIViewPropertyAnimator.init(duration: duration, curve: .linear, animations: {
                    
                    fromView.alpha = 0
                    toView.alpha = 1
                    
                })
                
                animator.addCompletion({ [unowned self] (position) in
                    
                    if self.transitionCompletion != nil {
                        let completed = position == .end
                        self.transitionCompletion!(completed)
                    }
                    
                })
                
                animator.isUserInteractionEnabled = false
                propertyAnimator = animator
                
                return }
        
        containerView.addSubview(view1)
        containerView.addSubview(view2)
        view1.frame = fromFrame1
        view2.frame = fromFrame2
        
        let animator: UIViewPropertyAnimator = UIViewPropertyAnimator.init(duration: duration, curve: .linear, animations: {
            
            view1.center = center1
            view2.center = center2
            
        })
        
        animator.addCompletion({ [unowned self] (position) in
            
            let completed = position == .end
            if !completed {
                toView.removeFromSuperview()
            }
            view1.removeFromSuperview()
            view2.removeFromSuperview()
            if self.transitionCompletion != nil {
                
                self.transitionCompletion!(completed)
            }
            
        })
        
        animator.isUserInteractionEnabled = false
        propertyAnimator = animator
        
        
    }
    
}
