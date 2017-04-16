//
//  MTBookTransition1.swift
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

class MTBookTransition1: MTLayerTransitionAnimator {
    
    override func setupTranisition(containerView: UIView, fromView: UIView, toView: UIView, fromViewFrame:CGRect, toViewFrame:CGRect) {
        
        var fromViewSnapshot: UIImage?
        var toViewSnapshot: UIImage?
        fromView.frame = fromViewFrame
        toView.frame = toViewFrame
        containerView.addSubview(toView)
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
        effectView.frame = containerView.frame
        containerView.addSubview(effectView)
        let transitionContainer = UIView.init(frame: effectView.bounds)
        effectView.contentView.addSubview(transitionContainer)
        var t = CATransform3DIdentity
        t.m34 = -1.0/(transitionContainer.bounds.size.height * 2.0)
        transitionContainer.layer.transform = t
        
        let fromContentLayer1 = CALayer()
        fromContentLayer1.frame = fromViewFrame
        fromContentLayer1.rasterizationScale = (fromViewSnapshot?.scale)!
        fromContentLayer1.masksToBounds = true
        fromContentLayer1.isDoubleSided = true
        fromContentLayer1.contents = fromViewSnapshot?.cgImage
        
        let fromContentLayer2 = CALayer()
        fromContentLayer2.frame = fromViewFrame
        fromContentLayer2.rasterizationScale = (fromViewSnapshot?.scale)!
        fromContentLayer2.masksToBounds = true
        fromContentLayer2.isDoubleSided = true
        fromContentLayer2.contents = fromViewSnapshot?.cgImage
        
        let toContentLayer1 = CALayer()
        toContentLayer1.frame = toViewFrame
        
        let toContentLayer2 = CALayer()
        toContentLayer2.frame = toViewFrame
        
        DispatchQueue.main.async {
            let wereActiondDisabled = CATransaction.disableActions()
            CATransaction.setDisableActions(true)
            toContentLayer1.rasterizationScale = (toViewSnapshot?.scale)!
            toContentLayer1.masksToBounds = true
            toContentLayer1.isDoubleSided = true
            toContentLayer1.contents = toViewSnapshot?.cgImage
            
            toContentLayer2.rasterizationScale = (toViewSnapshot?.scale)!
            toContentLayer2.masksToBounds = true
            toContentLayer2.isDoubleSided = true
            toContentLayer2.contents = toViewSnapshot?.cgImage
            
            CATransaction.setDisableActions(wereActiondDisabled)
            
        }
        
        setupTranisition(mainLayer: transitionContainer.layer, fromLayer1: fromContentLayer1, fromLayer2: fromContentLayer2,toLayer1: toContentLayer1, toLayer2: toContentLayer2, fromLayerFrame: fromViewFrame, toLayerFrame: toViewFrame)
        
    }
    
    func setupTranisition(mainLayer:CALayer, fromLayer1:CALayer, fromLayer2:CALayer,toLayer1:CALayer, toLayer2:CALayer, fromLayerFrame:CGRect, toLayerFrame:CGRect) {
        
        var t = CATransform3DIdentity
        t.m34 = 1.0 / -900.0
        mainLayer.sublayerTransform = t
        
        let frontLayer1 = CALayer()
        frontLayer1.frame = fromLayerFrame
        frontLayer1.rasterizationScale = fromLayer1.rasterizationScale
        frontLayer1.masksToBounds = true
        frontLayer1.isDoubleSided = true
        
        let frontLayer2 = CALayer()
        frontLayer2.frame = fromLayerFrame
        frontLayer2.rasterizationScale = fromLayer2.rasterizationScale
        frontLayer2.masksToBounds = true
        frontLayer2.isDoubleSided = true
        
        mainLayer.addSublayer(toLayer1)
        mainLayer.addSublayer(frontLayer1)
        mainLayer.addSublayer(frontLayer2)
        
        var angle = M_PI
        var valueFunction = CAValueFunction.init(name: kCAValueFunctionRotateY)
        let width = fromLayerFrame.width
        let height = fromLayerFrame.height
        var frontLayerTransform = CATransform3DIdentity
        var frontLayer = CALayer()
        
        switch transitionSubType {
        case .LeftToRight:
            
            let halfWidth = width/2.0
            frontLayer1.frame = CGRect(x: 0, y: 0, width: halfWidth, height: height)
            frontLayer2.frame = CGRect(x: halfWidth, y: 0, width: halfWidth, height: height)
            fromLayer2.frame = CGRect(x: -halfWidth, y: 0, width: width, height: height)
            toLayer2.frame = CGRect(x: 0, y: 0, width: width, height: height)
            
            angle = M_PI
            valueFunction = CAValueFunction.init(name: kCAValueFunctionRotateY)
            frontLayerTransform = CATransform3DMakeRotation(CGFloat(angle), 0, 1, 0)
            frontLayer1.zPosition = 1
            frontLayer1.addSublayer(toLayer2)
            let frame1 = frontLayer1.frame
            frontLayer1.anchorPoint = CGPoint.init(x: 1, y: 0.5)
            frontLayer1.frame = frame1
            frontLayer = frontLayer1
            
        case .RightToLeft:
            
            let halfWidth = width/2.0
            frontLayer1.frame = CGRect(x: 0, y: 0, width: halfWidth, height: height)
            frontLayer2.frame = CGRect(x: halfWidth, y: 0, width: halfWidth, height: height)
            fromLayer2.frame = CGRect(x: -halfWidth, y: 0, width: width, height: height)
            toLayer2.frame = CGRect(x: -halfWidth, y: 0, width: width, height: height)
            
            angle = -M_PI
            valueFunction = CAValueFunction.init(name: kCAValueFunctionRotateY)
            frontLayerTransform = CATransform3DMakeRotation(CGFloat(angle), 0, 1, 0)
            frontLayer2.addSublayer(toLayer2)
            frontLayer2.zPosition = 1
            let frame1 = frontLayer2.frame
            frontLayer2.anchorPoint = CGPoint.init(x: 0, y: 0.5)
            frontLayer2.frame = frame1
            frontLayer = frontLayer2
            
        case .TopToBottom:
            
            let halfHeight = height/2.0
            frontLayer1.frame = CGRect(x: 0, y: 0, width: width, height: halfHeight)
            frontLayer2.frame = CGRect(x: 0, y: halfHeight, width: width, height: halfHeight)
            fromLayer2.frame = CGRect(x: 0, y: -halfHeight, width: width, height: height)
            toLayer2.frame = CGRect(x: 0, y: 0, width: width, height: height)
            
            angle = -M_PI
            valueFunction = CAValueFunction.init(name: kCAValueFunctionRotateX)
            frontLayerTransform = CATransform3DMakeRotation(CGFloat(angle), 1, 0, 0)
            frontLayer1.addSublayer(toLayer2)
            frontLayer1.zPosition = 1
            let frame1 = frontLayer1.frame
            frontLayer1.anchorPoint = CGPoint.init(x: 0.5, y: 1)
            frontLayer1.frame = frame1
            frontLayer = frontLayer1
            
        case .BottomToTop:
            
            let halfHeight = height/2.0
            frontLayer1.frame = CGRect(x: 0, y: 0, width: width, height: halfHeight)
            frontLayer2.frame = CGRect(x: 0, y: halfHeight, width: width, height: halfHeight)
            fromLayer2.frame = CGRect(x: 0, y: -halfHeight, width: width, height: height)
            toLayer2.frame = CGRect(x: 0, y: -halfHeight, width: width, height: height)
            
            angle = M_PI
            valueFunction = CAValueFunction.init(name: kCAValueFunctionRotateX)
            frontLayerTransform = CATransform3DMakeRotation(CGFloat(angle), 1, 0, 0)
            frontLayer2.addSublayer(toLayer2)
            frontLayer2.zPosition = 1
            let frame1 = frontLayer2.frame
            frontLayer2.anchorPoint = CGPoint.init(x: 0.5, y: 0)
            frontLayer2.frame = frame1
            frontLayer = frontLayer2
            
        default:
            
            let halfWidth = width/2.0
            frontLayer1.frame = CGRect(x: 0, y: 0, width: halfWidth, height: height)
            frontLayer2.frame = CGRect(x: halfWidth, y: 0, width: halfWidth, height: height)
            fromLayer2.frame = CGRect(x: -halfWidth, y: 0, width: width, height: height)
            toLayer2.frame = CGRect(x: 0, y: 0, width: width, height: height)
            
            angle = M_PI
            valueFunction = CAValueFunction.init(name: kCAValueFunctionRotateY)
            frontLayerTransform = CATransform3DMakeRotation(CGFloat(angle), 0, 1, 0)
            frontLayer1.addSublayer(toLayer2)
            frontLayer1.zPosition = 1
            let frame1 = frontLayer1.frame
            frontLayer1.anchorPoint = CGPoint.init(x: 1, y: 0.5)
            frontLayer1.frame = frame1
            frontLayer = frontLayer1
            
        }
        
        frontLayer1.addSublayer(fromLayer1)
        frontLayer2.addSublayer(fromLayer2)
        
        DispatchQueue.main.async {
            let wereActiondDisabled = CATransaction.disableActions()
            CATransaction.setDisableActions(true)
            toLayer2.transform = frontLayerTransform;
            CATransaction.setDisableActions(wereActiondDisabled)
            
        }
        
        // Main Layer Animation
        
        let transform0 = mainLayer.transform
        let transform1 = CATransform3DTranslate(transform0, 0, 0, -200)
        
        let mainLayerTranslateAnimation = CAKeyframeAnimation(keyPath: "transform")
        mainLayerTranslateAnimation.beginTime = 0.0
        mainLayerTranslateAnimation.duration = self.duration
        mainLayerTranslateAnimation.isAdditive = true
        mainLayerTranslateAnimation.keyTimes = [0,0.5,1]
        mainLayerTranslateAnimation.values = [NSValue.init(caTransform3D: transform0),NSValue.init(caTransform3D:transform1),NSValue.init(caTransform3D:transform0)]
        
        // From Layer Animation
        
        let frontLayerRotationAnimation1 = CABasicAnimation(keyPath: "transform")
        frontLayerRotationAnimation1.fromValue = 0
        frontLayerRotationAnimation1.toValue = angle
        frontLayerRotationAnimation1.beginTime = 0;
        frontLayerRotationAnimation1.duration = self.duration
        frontLayerRotationAnimation1.valueFunction = valueFunction
        frontLayer.transform = frontLayerTransform
        
        let zPositionAnimation = CABasicAnimation(keyPath: "zPosition")
        zPositionAnimation.fromValue = -1
        zPositionAnimation.toValue = 1
        zPositionAnimation.beginTime = 0
        zPositionAnimation.duration = self.duration
        toLayer2.zPosition = 1
        
        let animator: MTLayerPropertyAnimator = MTLayerPropertyAnimator.init(duration: duration, curve: .linear, animations: { [unowned self] in
            
            self.effectView.contentView.backgroundColor = UIColor.clear
            mainLayer.add(mainLayerTranslateAnimation, forKey: nil)
            frontLayer.add(frontLayerRotationAnimation1, forKey: nil)
            toLayer2.add(zPositionAnimation, forKey: nil)
            
        })
        
        animator.addCompletion({ [unowned self] (position) in
            
            let completed = position == .end
            if !completed {
                self.secondView?.removeFromSuperview()
            }
            self.effectView.removeFromSuperview()
            if self.transitionCompletion != nil {
                self.transitionCompletion!(completed)
            }
            
        })
        animator.animationUpdated = ({
            
            frontLayer.transform = CATransform3DIdentity
            toLayer2.zPosition = -1
            
        })
        
        animator.isUserInteractionEnabled = false
        animator.mainlayer = mainLayer
        self.propertyAnimator = animator
        
        if self.isInteractive {
            animator.startInteractiveAnimation()
        }
        
    }
    
}
