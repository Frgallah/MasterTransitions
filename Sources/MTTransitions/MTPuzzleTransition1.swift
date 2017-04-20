//
//  MTPuzzleTransition1.swift
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

class MTPuzzleTransition1: MTTransitionAnimator {
    
    override func setupTranisition(containerView: UIView, fromView: UIView, toView: UIView, fromViewFrame: CGRect, toViewFrame: CGRect) {
        
        fromView.frame = fromViewFrame
        toView.frame = toViewFrame
        containerView.addSubview(toView)
        
        let transitionContainer = UIView.init(frame: containerView.bounds)
        containerView.addSubview(transitionContainer)
        
        let newFromView = fromView.snapshotView(afterScreenUpdates: false)
        transitionContainer.addSubview(newFromView!)
        
        var toViewSnapshot: UIImage?
        DispatchQueue.main.async {
            UIGraphicsBeginImageContextWithOptions(toView.bounds.size, true, (containerView.window?.screen.scale)!)
            toView.drawHierarchy(in: toView.bounds, afterScreenUpdates: false)
            toViewSnapshot = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        }
        
        var views: [UIView] = Array()
        let viewWidth = toViewFrame.width/3
        let viewHeight = toViewFrame.height/4
        let layerWidth = toViewFrame.width
        let layerHight = toViewFrame.height
        var x: CGFloat = 0
        var y: CGFloat = 0
        for n in 0...3 {
            for m in 0...2 {
                x = viewWidth * CGFloat(m)
                y = viewHeight * CGFloat(n)
                let view: UIView = UIView(frame: CGRect(x: x, y: y, width: viewWidth, height: viewHeight))
                let toContentLayer = CALayer()
                toContentLayer.frame = CGRect(x: -x, y: -y, width: layerWidth, height: layerHight)
                
                DispatchQueue.main.async {
                    let wereActiondDisabled = CATransaction.disableActions()
                    CATransaction.setDisableActions(true)
                    toContentLayer.rasterizationScale = (toViewSnapshot?.scale)!
                    toContentLayer.masksToBounds = true
                    toContentLayer.isDoubleSided = false
                    toContentLayer.contents = toViewSnapshot?.cgImage
                    CATransaction.setDisableActions(wereActiondDisabled)
                    
                }
                view.alpha = 0
                view.layer.masksToBounds = true
                view.layer.addSublayer(toContentLayer)
                transitionContainer.addSubview(view)
                views.append(view)
            }
        }
        
        let view1 = views[0]
        let view2 = views[1]
        let center2 = view2.center
        view2.center = CGPoint(x: center2.x, y: center2.y + viewHeight)
        let view3 = views[2]
        let center3 = view3.center
        view3.center = CGPoint(x: center3.x - viewWidth, y: center3.y)
        let view4 = views[3]
        let center4 = view4.center
        view4.center = CGPoint(x: center4.x, y: center4.y - viewHeight)
        let view5 = views[4]
        let center5 = view5.center
        view5.center = CGPoint(x: center5.x + viewWidth, y: center5.y)
        let view6 = views[5]
        let view7 = views[6]
        let view8 = views[7]
        let center8 = view8.center
        view8.center = CGPoint(x: center8.x - viewWidth, y: center8.y)
        let view9 = views[8]
        let center9 = view9.center
        view9.center = CGPoint(x: center9.x, y: center9.y + viewHeight)
        let view10 = views[9]
        let center10 = view10.center
        view10.center = CGPoint(x: center10.x + viewWidth, y: center10.y)
        let view11 = views[10]
        let center11 = view11.center
        view11.center = CGPoint(x: center11.x, y: center11.y - viewHeight)
        let view12 = views[11]
        
        let animator: UIViewPropertyAnimator = UIViewPropertyAnimator.init(duration: duration, curve: .linear, animations: {
            
            UIView.animateKeyframes(withDuration: self.duration, delay: 0, options: .calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
                    view3.alpha = 1
                    view10.alpha = 1
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2, animations: {
                    view2.alpha = 1
                    view11.alpha = 1
                    view3.center = center3
                    view10.center = center10
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2, animations: {
                    view4.alpha = 1
                    view5.alpha = 1
                    view8.alpha = 1
                    view9.alpha = 1
                    view2.center = center2
                    view11.center = center11
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2, animations: {
                    view4.center = center4
                    view5.center = center5
                    view8.center = center8
                    view9.center = center9
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
                    view1.alpha = 1
                    view6.alpha = 1
                    view7.alpha = 1
                    view12.alpha = 1
                })
                
            }, completion: nil)
            
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
        
        animator.isUserInteractionEnabled = false
        propertyAnimator = animator
        
    }
    
}
