//
//  MTBlindsTransition2.swift
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

class MTBlindsTransition2: MTLayerTransitionAnimator {
    
    override func setupTranisition(containerView: UIView, fromView: UIView, toView: UIView, fromViewFrame:CGRect, toViewFrame:CGRect) {
        
        var fromViewSnapshot: UIImage?
        var toViewSnapshot: UIImage?
        fromView.frame = fromViewFrame
        toView.frame = toViewFrame
        containerView.addSubview(toView)
        
        let transitionView = UIView.init(frame: containerView.bounds)
        transitionView.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        containerView.addSubview(transitionView)
        let transitionContainer = UIView.init(frame: containerView.bounds)
        // transitionContainer.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        transitionView.addSubview(transitionContainer)
        var t = CATransform3DIdentity
        t.m34 = 1 / -900
        transitionContainer.layer.transform = t
        let mainLayer = transitionContainer.layer
        
        var fromLayerWidth: CGFloat = 0
        var fromLayerHeight: CGFloat = 0
        var fromLayerX: CGFloat = 0
        var fromLayerY: CGFloat = 0
        let count: CGFloat = 9
        let fromViewWidth = fromViewFrame.width
        let fromViewHeight = fromViewFrame.height
        var xDistance: CGFloat = 0
        var yDistance: CGFloat = 0
        
        switch transitionSubType {
        case .LeftToRight:
            
            fromLayerWidth = fromViewWidth
            fromLayerHeight = fromViewHeight / count
            fromLayerX = 0
            fromLayerY = fromLayerHeight
            xDistance = toView.frame.width
            yDistance = 0
            
        case .RightToLeft:
            
            fromLayerWidth = fromViewWidth
            fromLayerHeight = fromViewHeight / count
            fromLayerX = 0
            fromLayerY = fromLayerHeight
            xDistance = -(toView.frame.width)
            yDistance = 0
            
        case .TopToBottom:
            
            fromLayerWidth = fromViewWidth / count
            fromLayerHeight = fromViewHeight
            fromLayerX = fromLayerWidth
            fromLayerY = 0
            xDistance = 0
            yDistance = toView.frame.height
            
        case .BottomToTop:
            
            fromLayerWidth = fromViewWidth / count
            fromLayerHeight = fromViewHeight
            fromLayerX = fromLayerWidth
            fromLayerY = 0
            xDistance = 0
            yDistance = -(toView.frame.height)
            
        default:
            
            fromLayerWidth = fromViewWidth
            fromLayerHeight = fromViewHeight / count
            fromLayerX = 0
            fromLayerY = fromLayerHeight
            xDistance = toView.frame.width
            yDistance = 0
            
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
        var layers: [(CALayer,CAKeyframeAnimation)] = Array()
        var zPosition: CGFloat = 1
        var i: CGFloat = 0
        while i < count {
            
            let x1 = fromLayerX * i
            let y1 = fromLayerY * i
            
            let fromLayer = CALayer()
            fromLayer.frame = CGRect(x: x1, y: y1, width: fromLayerWidth, height: fromLayerHeight)
            fromLayer.rasterizationScale = (fromViewSnapshot?.scale)!
            fromLayer.masksToBounds = true
            fromLayer.isDoubleSided = false
            fromLayer.transform = t
            fromLayer.zPosition = zPosition
            
            let fromContentLayer = CALayer()
            fromContentLayer.frame = CGRect(x: -x1, y: -y1, width: fromViewWidth, height: fromViewHeight)
            fromContentLayer.rasterizationScale = (fromViewSnapshot?.scale)!
            fromContentLayer.masksToBounds = true
            fromContentLayer.isDoubleSided = false
            fromContentLayer.contents = fromViewSnapshot?.cgImage
            
            fromLayer.addSublayer(fromContentLayer)
            mainLayer.addSublayer(fromLayer)
            
            if zPosition == 3 {
                let animation = CAKeyframeAnimation.init(keyPath: "opacity")
                animation.beginTime = 0.0;
                animation.duration = self.duration;
                animation.keyTimes = [0, 0.6, 1]
                animation.values = [1, 1, 0]
                fromLayer.opacity = 0
                
                layers.append((fromLayer,animation))
            }
            
            zPosition += 2
            if zPosition > 3 {
                zPosition = 1
            }
            i += 1
            
        }
        
        let toLayer = CALayer()
        toLayer.frame = toView.frame
        toLayer.zPosition = 2
        mainLayer.addSublayer(toLayer)
        
        DispatchQueue.main.async {
            let wereActiondDisabled = CATransaction.disableActions()
            CATransaction.setDisableActions(true)
            
            toLayer.rasterizationScale = (fromViewSnapshot?.scale)!
            toLayer.masksToBounds = true
            toLayer.isDoubleSided = false
            toLayer.contents = toViewSnapshot?.cgImage
            toLayer.transform = t
            
            CATransaction.setDisableActions(wereActiondDisabled)
            
        }
        
        let position1 = toLayer.position
        let position2 = CGPoint(x: toLayer.position.x - xDistance, y: toLayer.position.y - yDistance)
        
        let positionAnimation = CABasicAnimation.init(keyPath: "position")
        positionAnimation.beginTime = 0.0;
        positionAnimation.duration = self.duration * 0.8;
        positionAnimation.fromValue = position2
        positionAnimation.toValue = position1
        toLayer.position = position1
        
        let animator: MTLayerPropertyAnimator = MTLayerPropertyAnimator.init(duration: duration, curve: .linear, animations: { [unowned self] in
            
            transitionView.backgroundColor = self.backgroundColor
            toLayer.add(positionAnimation, forKey: nil)
            
            for (layer,animation) in layers {
                layer.add(animation, forKey: nil)
            }
            
        })
        
        animator.addCompletion({ [unowned self] (position) in
            
            let completed = position == .end
            if !completed {
                toView.removeFromSuperview()
            }
            transitionView.removeFromSuperview()
            if self.transitionCompletion != nil {
                self.transitionCompletion!(completed)
            }
            
        })
        
        animator.animationUpdated = ({
            
            toLayer.position = position2
            for (layer, _) in layers {
                layer.opacity = 1
            }
        })
        
        animator.isUserInteractionEnabled = false
        self.propertyAnimator = animator
        animator.mainlayer = mainLayer
        
        if self.isInteractive {
            animator.startInteractiveAnimation()
        }
    }
    
}

