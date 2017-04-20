//
//  MTSwingDoorTransition.swift
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

class MTSwingDoorTransition: MTLayerTransitionAnimator {
    
    override func setupTranisition(mainLayer:CALayer, fromLayer:CALayer, toLayer:CALayer, fromLayerFrame:CGRect, toLayerFrame:CGRect) {
        
        var t = CATransform3DIdentity
        t.m34 = 1.0 / -900.0
        
        let layer1 = CALayer()
        layer1.frame = fromLayer.bounds
        layer1.rasterizationScale = fromLayer.rasterizationScale
        layer1.masksToBounds = true
        layer1.isDoubleSided = false
        layer1.sublayerTransform = t
        layer1.addSublayer(fromLayer)
        
        let layer2 = CALayer()
        layer2.frame = toLayer.bounds
        layer2.rasterizationScale = toLayer.rasterizationScale
        layer2.masksToBounds = true
        layer2.isDoubleSided = false
        layer2.sublayerTransform = t
        layer2.addSublayer(toLayer)
        
        mainLayer.addSublayer(layer2)
        mainLayer.addSublayer(layer1)
        
        var anchorPoint1 = CGPoint.zero;
        var anchorPoint2 = CGPoint.zero;
        var transform1 = t
        var transform2 = t
        var angle = M_PI_2
        
        switch transitionSubType {
        case .LeftToRight:
            anchorPoint1 = CGPoint.init(x: 0, y: 0.5)
            anchorPoint2 = CGPoint.init(x: 1, y: 0.5)
            angle = M_PI_2
            transform1 = CATransform3DRotate(transform1,CGFloat(angle), 0, 1, 0)
            transform2 = CATransform3DRotate(transform2,CGFloat(-angle), 0, 1, 0)
            
        case .RightToLeft:
            anchorPoint1 = CGPoint.init(x: 1, y: 0.5)
            anchorPoint2 = CGPoint.init(x: 0, y: 0.5)
            angle = -M_PI_2
            transform1 = CATransform3DRotate(transform1,CGFloat(angle), 0, 1, 0)
            transform2 = CATransform3DRotate(transform2,CGFloat(-angle), 0, 1, 0)
            
        case .TopToBottom:
            anchorPoint1 = CGPoint.init(x: 0.5, y: 1)
            anchorPoint2 = CGPoint.init(x: 0.5, y: 0)
            angle = M_PI_2
            transform1 = CATransform3DRotate(fromLayer.transform,CGFloat(angle), 1, 0, 0)
            transform2 = CATransform3DRotate(toLayer.transform,CGFloat(-angle), 1, 0, 0)
        case .BottomToTop:
            anchorPoint1 = CGPoint.init(x: 0.5, y: 0)
            anchorPoint2 = CGPoint.init(x: 0.5, y: 1)
            angle = -M_PI_2
            transform1 = CATransform3DRotate(fromLayer.transform,CGFloat(angle), 1, 0, 0)
            transform2 = CATransform3DRotate(toLayer.transform,CGFloat(-angle), 1, 0, 0)
        default:
            anchorPoint1 = CGPoint.init(x: 0, y: 0.5)
            anchorPoint2 = CGPoint.init(x: 1, y: 0.5)
            angle = M_PI_2
            transform1 = CATransform3DRotate(transform1,CGFloat(angle), 0, 1, 0)
            transform2 = CATransform3DRotate(transform2,CGFloat(-angle), 0, 1, 0)
        }
        
        let wereActiondDisabled = CATransaction.disableActions()
        CATransaction.setDisableActions(true)
        let frame1 = layer1.frame
        layer1.anchorPoint = anchorPoint1
        layer1.frame = frame1
        let frame2 = layer2.frame
        layer2.anchorPoint = anchorPoint2
        layer2.frame = frame2
        layer2.sublayerTransform = transform2
        CATransaction.setDisableActions(wereActiondDisabled)
        
        let transform = layer1.sublayerTransform
        
        // From Layer Animation
        
        let fromLayerRotationAnimation = CABasicAnimation(keyPath: "sublayerTransform")
        fromLayerRotationAnimation.fromValue = layer1.sublayerTransform
        fromLayerRotationAnimation.toValue = transform1
        fromLayerRotationAnimation.beginTime = 0
        fromLayerRotationAnimation.duration = self.duration
        layer1.sublayerTransform = transform1
        
        // To Layer Animation
        
        let toLayerRotationAnimation = CABasicAnimation(keyPath: "sublayerTransform")
        toLayerRotationAnimation.fromValue = layer2.sublayerTransform
        toLayerRotationAnimation.toValue = t
        toLayerRotationAnimation.beginTime = 0
        toLayerRotationAnimation.duration = self.duration
        layer2.sublayerTransform = t
        
        let animator: MTLayerPropertyAnimator = MTLayerPropertyAnimator.init(duration: duration, curve: .linear, animations: { [unowned self] in
            
            self.transitionView?.backgroundColor = self.backgroundColor
            
            layer1.add(fromLayerRotationAnimation, forKey: nil)
            layer2.add(toLayerRotationAnimation, forKey: nil)
            
        })
        
        animator.addCompletion({ [unowned self] (position) in
            
            let completed = position == .end
            if !completed {
                self.secondView?.removeFromSuperview()
            }
            self.transitionView?.removeFromSuperview()
            if self.transitionCompletion != nil {
                self.transitionCompletion!(completed)
            }
            
        })
        animator.animationUpdated = ({
            layer1.sublayerTransform = transform
            layer2.sublayerTransform = transform2
        })
        
        animator.isUserInteractionEnabled = false
        animator.mainlayer = mainLayer
        self.propertyAnimator = animator
        
        if self.isInteractive {
            animator.startInteractiveAnimation()
        }
        
        
    }
    
    
}
