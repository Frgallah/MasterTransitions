//
//  MTFolderTransition1.swift
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

class FolderTransition1: LayerTransitionAnimator {
    
    override func setupTranisition(containerView: UIView, fromView: UIView, toView: UIView, fromViewFrame:CGRect, toViewFrame:CGRect) {
        
        var fromViewSnapshot: UIImage?
        var toViewSnapshot: UIImage?
        fromView.frame = fromViewFrame
        toView.frame = toViewFrame
        containerView.addSubview(toView)
        secondView = toView
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
       
        let transitionView = UIView.init(frame: containerView.bounds)
        transitionView.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        containerView.addSubview(transitionView)
        let transitionContainer = UIView.init(frame: containerView.bounds)
        // transitionContainer.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        transitionView.addSubview(transitionContainer)
        self.transitionView = transitionView
        var t = CATransform3DIdentity
        t.m34 = -1.0/(transitionContainer.bounds.size.height * 2.0)
        transitionContainer.layer.transform = t
        
        let fromContentLayer1 = CALayer()
        fromContentLayer1.frame = fromViewFrame
        fromContentLayer1.rasterizationScale = (fromViewSnapshot?.scale)!
        fromContentLayer1.masksToBounds = true
        fromContentLayer1.isDoubleSided = false
        fromContentLayer1.contents = fromViewSnapshot?.cgImage
        
        let fromContentLayer2 = CALayer()
        fromContentLayer2.frame = fromViewFrame
        fromContentLayer2.rasterizationScale = (fromViewSnapshot?.scale)!
        fromContentLayer2.masksToBounds = true
        fromContentLayer2.isDoubleSided = false
        fromContentLayer2.contents = fromViewSnapshot?.cgImage
        
        let toContentLayer = CALayer()
        toContentLayer.frame = fromViewFrame
        DispatchQueue.main.async {
            let wereActiondDisabled = CATransaction.disableActions()
            CATransaction.setDisableActions(true)
            toContentLayer.rasterizationScale = (toViewSnapshot?.scale)!
            toContentLayer.masksToBounds = true
            toContentLayer.isDoubleSided = false
            toContentLayer.contents = toViewSnapshot?.cgImage
            CATransaction.setDisableActions(wereActiondDisabled)
            
        }
        
        setupTranisition(mainLayer: transitionContainer.layer, fromLayer1: fromContentLayer1, fromLayer2: fromContentLayer2, toLayer: toContentLayer, fromLayerFrame: fromViewFrame, toLayerFrame: toViewFrame)
        
    }
    
    func setupTranisition(mainLayer:CALayer, fromLayer1:CALayer, fromLayer2:CALayer,toLayer:CALayer, fromLayerFrame:CGRect, toLayerFrame:CGRect) {
        
        var t = CATransform3DIdentity
        t.m34 = 1.0 / -900.0
        mainLayer.sublayerTransform = t
        
        let frontLayer1 = CALayer()
        frontLayer1.frame = fromLayerFrame
        frontLayer1.rasterizationScale = fromLayer1.rasterizationScale
        frontLayer1.masksToBounds = true
        frontLayer1.isDoubleSided = false
        frontLayer1.addSublayer(fromLayer1)
        
        let frontLayer2 = CALayer()
        frontLayer2.frame = fromLayerFrame
        frontLayer2.rasterizationScale = fromLayer2.rasterizationScale
        frontLayer2.masksToBounds = true
        frontLayer2.isDoubleSided = false
        frontLayer2.addSublayer(fromLayer2)
        
        mainLayer.addSublayer(toLayer)
        mainLayer.addSublayer(frontLayer1)
        mainLayer.addSublayer(frontLayer2)
        
        var anchorPoint1 = CGPoint.zero;
        var anchorPoint2 = CGPoint.zero;
        var angle1 = -M_PI_2
        var angle2 = M_PI_2
        let width = fromLayerFrame.width
        let height = fromLayerFrame.height
        var frontLayerTransform1 = CATransform3DIdentity
        var frontLayerTransform2 = CATransform3DIdentity
        
        switch transitionSubType {
        case .Horizontal:
            
            let halfWidth = width/2.0
            frontLayer1.frame = CGRect(x: 0, y: 0, width: halfWidth, height: height)
            frontLayer2.frame = CGRect(x: halfWidth, y: 0, width: halfWidth, height: height)
            fromLayer2.frame = CGRect(x: -halfWidth, y: 0, width: width, height: height)
            anchorPoint1 = CGPoint.init(x: 1, y: 0.5)
            anchorPoint2 = CGPoint.init(x: 0, y: 0.5)
            angle1 = M_PI_2
            angle2 = -M_PI_2
            frontLayerTransform1 = CATransform3DMakeRotation(CGFloat(angle1), 0, 1, 0)
            frontLayerTransform2 = CATransform3DMakeRotation(CGFloat(angle2), 0, 1, 0)
            
        case .Vertical:
            
            let halfHeight = height/2.0
            frontLayer1.frame = CGRect(x: 0, y: 0, width: width, height: halfHeight)
            frontLayer2.frame = CGRect(x: 0, y: halfHeight, width: width, height: halfHeight)
            fromLayer2.frame = CGRect(x: 0, y: -halfHeight, width: width, height: height)
            anchorPoint1 = CGPoint.init(x: 0.5, y: 1)
            anchorPoint2 = CGPoint.init(x: 0.5, y: 0)
            angle1 = -M_PI_2
            angle2 = M_PI_2
            frontLayerTransform1 = CATransform3DMakeRotation(CGFloat(angle1), 1, 0, 0)
            frontLayerTransform2 = CATransform3DMakeRotation(CGFloat(angle2), 1, 0, 0)
            
        default:
            
            let halfWidth = width/2.0
            frontLayer1.frame = CGRect(x: 0, y: 0, width: halfWidth, height: height)
            frontLayer2.frame = CGRect(x: halfWidth, y: 0, width: halfWidth, height: height)
            fromLayer2.frame = CGRect(x: -halfWidth, y: 0, width: width, height: height)
            anchorPoint1 = CGPoint.init(x: 1, y: 0.5)
            anchorPoint2 = CGPoint.init(x: 0, y: 0.5)
            angle1 = M_PI_2
            angle2 = -M_PI_2
            frontLayerTransform1 = CATransform3DMakeRotation(CGFloat(angle1), 0, 1, 0)
            frontLayerTransform2 = CATransform3DMakeRotation(CGFloat(angle2), 0, 1, 0)
            
        }
        
        let wereActiondDisabled = CATransaction.disableActions()
        CATransaction.setDisableActions(true)
        let frame1 = frontLayer1.frame
        frontLayer1.anchorPoint = anchorPoint1
        frontLayer1.frame = frame1
        let frame2 = frontLayer2.frame
        frontLayer2.anchorPoint = anchorPoint2
        frontLayer2.frame = frame2
        CATransaction.setDisableActions(wereActiondDisabled)
        
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
        frontLayerRotationAnimation1.fromValue = frontLayer1.transform
        frontLayerRotationAnimation1.toValue = frontLayerTransform1
        frontLayerRotationAnimation1.beginTime = 0;
        frontLayerRotationAnimation1.duration = self.duration
        frontLayer1.transform = frontLayerTransform1
        
        // To Layer Animation
        
        let frontLayerRotationAnimation2 = CABasicAnimation(keyPath: "transform")
        frontLayerRotationAnimation2.fromValue = frontLayer2.transform
        frontLayerRotationAnimation2.toValue = frontLayerTransform2
        frontLayerRotationAnimation2.beginTime = 0
        frontLayerRotationAnimation2.duration = self.duration
        frontLayer2.transform = frontLayerTransform2
        
        let animator: LayerPropertyAnimator = LayerPropertyAnimator.init(duration: duration, curve: .linear, animations: { [unowned self] in
            
            self.transitionView?.backgroundColor = self.backgroundColor
            mainLayer.add(mainLayerTranslateAnimation, forKey: nil)
            frontLayer1.add(frontLayerRotationAnimation1, forKey: nil)
            frontLayer2.add(frontLayerRotationAnimation2, forKey: nil)
            
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
            
            frontLayer1.transform = CATransform3DIdentity
            frontLayer2.transform = CATransform3DIdentity
            
        })
        
        animator.isUserInteractionEnabled = false
        animator.mainlayer = mainLayer
        self.propertyAnimator = animator
        
        if self.isInteractive {
            animator.startInteractiveAnimation()
        }
        
    }
    
}

