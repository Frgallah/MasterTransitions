//
//  MTCubeTransition1.swift
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

class MTCubeTransition1: MTLayerTransitionAnimator {
    
    override func setupTranisition(containerView: UIView, fromView: UIView, toView: UIView, fromViewFrame:CGRect, toViewFrame:CGRect) {
        
        var fromViewSnapshot: UIImage?
        var toViewSnapshot: UIImage?
        fromView.frame = fromViewFrame
        toView.frame = toViewFrame
        containerView.addSubview(toView)
        
        let transitionContainer = UIView.init(frame: containerView.bounds)
        transitionContainer.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        containerView.addSubview(transitionContainer)
        var t = CATransform3DIdentity
        t.m34 = 1 / -900
        
        let angle = M_PI_2
        var mainLayerTransform = t
        var toContentLayerTransform1 = CATransform3DIdentity
        var toContentLayerTransform2 = CATransform3DIdentity
        
        switch transitionSubType {
        case .LeftToRight:
            
            let width = toViewFrame.width
            toContentLayerTransform1 =  CATransform3DTranslate(toContentLayerTransform1,0, 0, -width/2.0)
            toContentLayerTransform1 = CATransform3DRotate(toContentLayerTransform1,CGFloat(angle), 0, 1, 0)
            toContentLayerTransform1 =  CATransform3DTranslate(toContentLayerTransform1,0, 0, width/2.0)
            toContentLayerTransform2 =  CATransform3DTranslate(toContentLayerTransform2,0, 0, -width/2.0)
            toContentLayerTransform2 = CATransform3DRotate(toContentLayerTransform2,CGFloat(-angle), 0, 1, 0)
            toContentLayerTransform2 =  CATransform3DTranslate(toContentLayerTransform2,0, 0, width/2.0)
            
            mainLayerTransform =  CATransform3DTranslate(mainLayerTransform,0, 0, -width/2.0)
            mainLayerTransform = CATransform3DRotate(mainLayerTransform,CGFloat(angle), 0, 1, 0)
            mainLayerTransform =  CATransform3DTranslate(mainLayerTransform,0, 0, width/2.0)
            
        case .RightToLeft:
            
            let width = toViewFrame.width
            toContentLayerTransform1 =  CATransform3DTranslate(toContentLayerTransform1,0, 0, -width/2.0)
            toContentLayerTransform1 = CATransform3DRotate(toContentLayerTransform1,CGFloat(angle), 0, 1, 0)
            toContentLayerTransform1 =  CATransform3DTranslate(toContentLayerTransform1,0, 0, width/2.0)
            toContentLayerTransform2 =  CATransform3DTranslate(toContentLayerTransform2,0, 0, -width/2.0)
            toContentLayerTransform2 = CATransform3DRotate(toContentLayerTransform2,CGFloat(-angle), 0, 1, 0)
            toContentLayerTransform2 =  CATransform3DTranslate(toContentLayerTransform2,0, 0, width/2.0)
            
            mainLayerTransform =  CATransform3DTranslate(mainLayerTransform,0, 0, -width/2.0)
            mainLayerTransform = CATransform3DRotate(mainLayerTransform,CGFloat(-angle), 0, 1, 0)
            mainLayerTransform =  CATransform3DTranslate(mainLayerTransform,0, 0, width/2.0)
            
        case .TopToBottom:
            
            let height = toViewFrame.height
            toContentLayerTransform1 =  CATransform3DTranslate(toContentLayerTransform1,0, 0, -height/2.0)
            toContentLayerTransform1 = CATransform3DRotate(toContentLayerTransform1,CGFloat(-angle), 1, 0, 0)
            toContentLayerTransform1 =  CATransform3DTranslate(toContentLayerTransform1,0, 0, height/2.0)
            toContentLayerTransform2 =  CATransform3DTranslate(toContentLayerTransform2,0, 0, -height/2.0)
            toContentLayerTransform2 = CATransform3DRotate(toContentLayerTransform2,CGFloat(angle), 1, 0, 0)
            toContentLayerTransform2 =  CATransform3DTranslate(toContentLayerTransform2,0, 0, height/2.0)
            mainLayerTransform =  CATransform3DTranslate(mainLayerTransform,0, 0, -height/2.0)
            mainLayerTransform = CATransform3DRotate(mainLayerTransform,CGFloat(-angle), 1, 0, 0)
            mainLayerTransform =  CATransform3DTranslate(mainLayerTransform,0, 0, height/2.0)
            
        case .BottomToTop:
            
            let height = toViewFrame.height
            
            toContentLayerTransform1 =  CATransform3DTranslate(toContentLayerTransform1,0, 0, -height/2.0)
            toContentLayerTransform1 = CATransform3DRotate(toContentLayerTransform1,CGFloat(-angle), 1, 0, 0)
            toContentLayerTransform1 =  CATransform3DTranslate(toContentLayerTransform1,0, 0, height/2.0)
            toContentLayerTransform2 =  CATransform3DTranslate(toContentLayerTransform2,0, 0, -height/2.0)
            toContentLayerTransform2 = CATransform3DRotate(toContentLayerTransform2,CGFloat(angle), 1, 0, 0)
            toContentLayerTransform2 =  CATransform3DTranslate(toContentLayerTransform2,0, 0, height/2.0)
            mainLayerTransform =  CATransform3DTranslate(mainLayerTransform,0, 0, -height/2.0)
            mainLayerTransform = CATransform3DRotate(mainLayerTransform,CGFloat(angle), 1, 0, 0)
            mainLayerTransform =  CATransform3DTranslate(mainLayerTransform,0, 0, height/2.0)
            
        default:
            
            let width = toViewFrame.width
            
            toContentLayerTransform1 =  CATransform3DTranslate(toContentLayerTransform1,0, 0, -width/2.0)
            toContentLayerTransform1 = CATransform3DRotate(toContentLayerTransform1,CGFloat(-angle), 0, 1, 0)
            toContentLayerTransform1 =  CATransform3DTranslate(toContentLayerTransform1,0, 0, width/2.0)
            toContentLayerTransform2 =  CATransform3DTranslate(toContentLayerTransform2,0, 0, -width/2.0)
            toContentLayerTransform2 = CATransform3DRotate(toContentLayerTransform2,CGFloat(angle), 0, 1, 0)
            toContentLayerTransform2 =  CATransform3DTranslate(toContentLayerTransform2,0, 0, width/2.0)
            mainLayerTransform =  CATransform3DTranslate(mainLayerTransform,0, 0, -width/2.0)
            mainLayerTransform = CATransform3DRotate(mainLayerTransform,CGFloat(angle), 0, 1, 0)
            mainLayerTransform =  CATransform3DTranslate(mainLayerTransform,0, 0, width/2.0)
            
            
        }
        
        UIGraphicsBeginImageContextWithOptions(fromView.bounds.size, true, (containerView.window?.screen.scale)!)
        fromView.drawHierarchy(in: fromView.bounds, afterScreenUpdates: false)
        fromViewSnapshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        DispatchQueue.main.async {
            UIGraphicsBeginImageContextWithOptions(toView.bounds.size, true, (containerView.window?.screen.scale)!)
            toView.drawHierarchy(in: toView.bounds, afterScreenUpdates: false)
            toViewSnapshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        
        let fromContentLayer = CALayer()
        fromContentLayer.frame = fromViewFrame
        fromContentLayer.rasterizationScale = (fromViewSnapshot?.scale)!
        fromContentLayer.masksToBounds = true
        fromContentLayer.isDoubleSided = false
        fromContentLayer.contents = fromViewSnapshot?.cgImage
        fromContentLayer.transform = t
        
        let toContentLayer1 = CALayer()
        toContentLayer1.frame = toViewFrame
        
        let toContentLayer2 = CALayer()
        toContentLayer2.frame = toViewFrame
        
        DispatchQueue.main.async {
            let wereActiondDisabled = CATransaction.disableActions()
            CATransaction.setDisableActions(true)
            toContentLayer1.transform = toContentLayerTransform1
            toContentLayer1.rasterizationScale = (toViewSnapshot?.scale)!
            toContentLayer1.masksToBounds = true
            toContentLayer1.contents = toViewSnapshot?.cgImage
            
            toContentLayer2.transform = toContentLayerTransform2
            toContentLayer2.rasterizationScale = (toViewSnapshot?.scale)!
            toContentLayer2.masksToBounds = true
            toContentLayer2.contents = toViewSnapshot?.cgImage
            CATransaction.setDisableActions(wereActiondDisabled)
            
        }
        
        let cubeView = UIView(frame: transitionContainer.bounds)
        let layer = cubeView.layer
        layer.masksToBounds = true
        layer.addSublayer(toContentLayer1)
        layer.addSublayer(toContentLayer2)
        layer.addSublayer(fromContentLayer)
        transitionContainer.addSubview(cubeView)
        
        let positionAnimation = CABasicAnimation.init(keyPath: "sublayerTransform")
        positionAnimation.beginTime = 0.0;
        positionAnimation.duration = self.duration;
        positionAnimation.fromValue = layer.transform
        positionAnimation.toValue = mainLayerTransform
        layer.sublayerTransform = mainLayerTransform
        
        let animator: MTLayerPropertyAnimator = MTLayerPropertyAnimator.init(duration: duration, curve: .linear, animations: { [unowned self] in
            
            transitionContainer.backgroundColor = self.backgroundColor
            layer.add(positionAnimation, forKey: nil)
            
        })
        
        animator.addCompletion({ [unowned self] (position) in
            
            let completed = position == .end
            if !completed {
                toView.removeFromSuperview()
            }
            transitionContainer.removeFromSuperview()
            if self.transitionCompletion != nil {
                self.transitionCompletion!(completed)
            }
            
        })
        animator.animationUpdated = ({
            
            layer.sublayerTransform = CATransform3DIdentity
            
        })
        
        animator.isUserInteractionEnabled = false
        animator.mainlayer = layer
        self.propertyAnimator = animator
        
        if self.isInteractive {
            animator.startInteractiveAnimation()
        }
        
        
    }
    
}
