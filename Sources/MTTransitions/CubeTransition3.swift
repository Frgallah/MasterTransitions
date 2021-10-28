//
//  MTCubeTransition3.swift
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

class CubeTransition3: LayerTransitionAnimator {
    
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
        
        let angle = Double.pi / 2
        var mainLayerTransform = t
        var toContentLayerTransform1 = CATransform3DIdentity
        var toContentLayerTransform2 = CATransform3DIdentity
        var cubeViewFrame1 = CGRect.zero
        var cubeViewFrame2 = CGRect.zero
        var cubeViewFrame3 = CGRect.zero
        var cubeViewFrame4 = CGRect.zero
        var x: CGFloat = 0
        var y: CGFloat = 0
        
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
            
            let cubeViewWidth = containerView.bounds.width
            let cubeViewHeight = containerView.bounds.height/4.0
            cubeViewFrame1 = CGRect(x: 0, y: 0, width: cubeViewWidth, height: cubeViewHeight)
            cubeViewFrame2 = CGRect(x: 0, y: cubeViewHeight, width: cubeViewWidth, height: cubeViewHeight)
            cubeViewFrame3 = CGRect(x: 0, y: cubeViewHeight * 2, width: cubeViewWidth, height: cubeViewHeight)
            cubeViewFrame4 = CGRect(x: 0, y: cubeViewHeight * 3, width: cubeViewWidth, height: cubeViewHeight)
            x = 0
            y = -(cubeViewHeight)
            
            
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
            
            let cubeViewWidth = containerView.bounds.width
            let cubeViewHeight = containerView.bounds.height/4.0
            cubeViewFrame1 = CGRect(x: 0, y: 0, width: cubeViewWidth, height: cubeViewHeight)
            cubeViewFrame2 = CGRect(x: 0, y: cubeViewHeight, width: cubeViewWidth, height: cubeViewHeight)
            cubeViewFrame3 = CGRect(x: 0, y: cubeViewHeight * 2, width: cubeViewWidth, height: cubeViewHeight)
            cubeViewFrame4 = CGRect(x: 0, y: cubeViewHeight * 3, width: cubeViewWidth, height: cubeViewHeight)
            x = 0
            y = -(cubeViewHeight)
            
            
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
            
            let cubeViewWidth = containerView.bounds.width/4.0
            let cubeViewHeight = containerView.bounds.height
            cubeViewFrame1 = CGRect(x: 0, y: 0, width: cubeViewWidth, height: cubeViewHeight)
            cubeViewFrame2 = CGRect(x: cubeViewWidth, y: 0, width: cubeViewWidth, height: cubeViewHeight)
            cubeViewFrame3 = CGRect(x: cubeViewWidth * 2, y: 0, width: cubeViewWidth, height: cubeViewHeight)
            cubeViewFrame4 = CGRect(x: cubeViewWidth * 3, y: 0, width: cubeViewWidth, height: cubeViewHeight)
            x = -(cubeViewWidth)
            y = 0
            
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
            
            let cubeViewWidth = containerView.bounds.width/4.0
            let cubeViewHeight = containerView.bounds.height
            cubeViewFrame1 = CGRect(x: 0, y: 0, width: cubeViewWidth, height: cubeViewHeight)
            cubeViewFrame2 = CGRect(x: cubeViewWidth, y: 0, width: cubeViewWidth, height: cubeViewHeight)
            cubeViewFrame3 = CGRect(x: cubeViewWidth * 2, y: 0, width: cubeViewWidth, height: cubeViewHeight)
            cubeViewFrame4 = CGRect(x: cubeViewWidth * 3, y: 0, width: cubeViewWidth, height: cubeViewHeight)
            x = -(cubeViewWidth)
            y = 0
            
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
            
            let cubeViewWidth = containerView.bounds.width
            let cubeViewHeight = containerView.bounds.height/4.0
            cubeViewFrame1 = CGRect(x: 0, y: 0, width: cubeViewWidth, height: cubeViewHeight)
            cubeViewFrame2 = CGRect(x: 0, y: cubeViewHeight, width: cubeViewWidth, height: cubeViewHeight)
            cubeViewFrame3 = CGRect(x: 0, y: cubeViewHeight * 2, width: cubeViewWidth, height: cubeViewHeight)
            cubeViewFrame4 = CGRect(x: 0, y: cubeViewHeight * 3, width: cubeViewWidth, height: cubeViewHeight)
            x = 0
            y = -(cubeViewHeight)
            
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
        
        let cubeView1 = CALayer()
        let cubeView2 = CALayer()
        let cubeView3 = CALayer()
        let cubeView4 = CALayer()
        cubeView1.frame = cubeViewFrame1
        cubeView2.frame = cubeViewFrame2
        cubeView3.frame = cubeViewFrame3
        cubeView4.frame = cubeViewFrame4
        let cubeViews = [cubeView1,cubeView2,cubeView3,cubeView4]
        
        let fromLayerWidth = fromViewFrame.width
        let fromLayerHeight = fromViewFrame.height
        let toLayerWidth = toViewFrame.width
        let toLayerHeight = toViewFrame.height
        var count: CGFloat = 0
        
        for cubeView in cubeViews {
            let fromContentLayer = CALayer()
            fromContentLayer.frame = CGRect(x: x * count, y: y * count, width: fromLayerWidth, height: fromLayerHeight)
            fromContentLayer.rasterizationScale = (fromViewSnapshot?.scale)!
            fromContentLayer.masksToBounds = true
            fromContentLayer.isDoubleSided = false
            fromContentLayer.contents = fromViewSnapshot?.cgImage
            fromContentLayer.transform = t
            
            let toContentLayer1 = CALayer()
            toContentLayer1.frame = CGRect(x: x * count, y: y * count, width: toLayerWidth, height: toLayerHeight)
            
            let toContentLayer2 = CALayer()
            toContentLayer2.frame = CGRect(x: x * count, y: y * count, width: toLayerWidth, height: toLayerHeight)
            
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
            
            cubeView.masksToBounds = true
            cubeView.addSublayer(toContentLayer1)
            cubeView.addSublayer(toContentLayer2)
            cubeView.addSublayer(fromContentLayer)
            transitionContainer.layer.addSublayer(cubeView)
            count += 1
        }
        
        let positionAnimation1 = CABasicAnimation.init(keyPath: "sublayerTransform")
        positionAnimation1.beginTime = 0.0;
        positionAnimation1.duration = self.duration * 0.4;
        positionAnimation1.fromValue = cubeView1.transform
        positionAnimation1.toValue = mainLayerTransform
        cubeView1.sublayerTransform = mainLayerTransform
        
        let positionAnimation2 = CAKeyframeAnimation.init(keyPath: "sublayerTransform")
        positionAnimation2.beginTime = 0;
        positionAnimation2.duration = self.duration
        positionAnimation2.keyTimes = [0, 0.2, 0.6, 1]
        positionAnimation2.values = [cubeView2.transform,cubeView2.transform,mainLayerTransform,mainLayerTransform]
        cubeView2.sublayerTransform = mainLayerTransform
        
        let positionAnimation3 = CAKeyframeAnimation.init(keyPath: "sublayerTransform")
        positionAnimation3.beginTime = 0
        positionAnimation3.duration = self.duration
        positionAnimation3.keyTimes = [0, 0.4, 0.8, 1]
        positionAnimation3.values = [cubeView3.transform,cubeView3.transform,mainLayerTransform,mainLayerTransform]
        cubeView3.sublayerTransform = mainLayerTransform
        
        let positionAnimation4 = CAKeyframeAnimation.init(keyPath: "sublayerTransform")
        positionAnimation4.beginTime = 0
        positionAnimation4.duration = self.duration
        positionAnimation4.keyTimes = [0, 0.6, 1]
        positionAnimation4.values = [cubeView4.transform,cubeView4.transform,mainLayerTransform]
        cubeView4.sublayerTransform = mainLayerTransform
        
        let animator: LayerPropertyAnimator = LayerPropertyAnimator.init(duration: duration, curve: .linear, animations: { [unowned self] in
            
            transitionView.backgroundColor = self.backgroundColor
            cubeView1.add(positionAnimation1, forKey: nil)
            cubeView2.add(positionAnimation2, forKey: nil)
            cubeView3.add(positionAnimation3, forKey: nil)
            cubeView4.add(positionAnimation4, forKey: nil)
            
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
            
            cubeView1.sublayerTransform = CATransform3DIdentity
            cubeView2.sublayerTransform = CATransform3DIdentity
            cubeView3.sublayerTransform = CATransform3DIdentity
            cubeView4.sublayerTransform = CATransform3DIdentity
            
        })
        
        animator.isUserInteractionEnabled = false
        animator.mainlayer = transitionContainer.layer
        self.propertyAnimator = animator
        if self.isInteractive {
            animator.startInteractiveAnimation()
        }
        
    }
    
}
