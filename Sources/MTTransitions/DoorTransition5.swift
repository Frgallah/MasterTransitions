//
//  MTDoorTransition5.swift
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

class DoorTransition5: TransitionAnimator {
    
    override func setupTranisition(containerView: UIView, fromView: UIView, toView: UIView, fromViewFrame: CGRect, toViewFrame: CGRect) {
        
        fromView.frame = fromViewFrame
        toView.frame = toViewFrame
        containerView.addSubview(toView)
        let fromView1 = UIView()
        let fromView2 = UIView()
        var center1 = CGPoint.zero
        var center2 = CGPoint.zero
        
        var fromViewSnapshot: UIImage?
        UIGraphicsBeginImageContextWithOptions(fromView.bounds.size, true, (containerView.window?.screen.scale)!)
        fromView.drawHierarchy(in: fromView.bounds, afterScreenUpdates: false)
        fromViewSnapshot = UIGraphicsGetImageFromCurrentImageContext()
        
        var count: CGFloat = 7
        
        switch transitionSubType {
        case .Horizontal:
            let width = fromViewFrame.width
            let height = fromViewFrame.height
            let viewWidth = fromViewFrame.width * 0.6
            let frontLayerWidth = fromViewFrame.width - viewWidth
            let backLayerHeight = fromViewFrame.height / count
            
            fromView1.frame = CGRect(x: 0, y: 0, width: viewWidth, height: height)
            fromView2.frame = CGRect(x: frontLayerWidth, y: 0, width: viewWidth, height: height)
            
            var i: CGFloat = 0
            while i < count {
                let frame = CGRect(x: 0, y: i * backLayerHeight, width: viewWidth, height: backLayerHeight)
                let contentFrame = CGRect(x: 0, y: -(i * backLayerHeight), width: width, height: height)
                fromView1.layer.addSublayer(addLayerWith(frame: frame, contentsFrame: contentFrame, contents: fromViewSnapshot!))
                i += 2
            }
            var n: CGFloat = 1
            while n < count {
                let frame = CGRect(x: 0, y: n * backLayerHeight, width: viewWidth, height: backLayerHeight)
                let contentFrame = CGRect(x: -(frontLayerWidth), y: -(n * backLayerHeight), width: width, height: height)
                fromView2.layer.addSublayer(addLayerWith(frame: frame, contentsFrame: contentFrame, contents: fromViewSnapshot!))
                n += 2
            }
            fromView1.layer.addSublayer(addLayerWith(frame: CGRect(x: 0,y: 0, width: frontLayerWidth,height: height), contentsFrame: fromViewFrame, contents: fromViewSnapshot!))
            fromView2.layer.addSublayer(addLayerWith(frame: CGRect(x: viewWidth - frontLayerWidth,y: 0, width: frontLayerWidth,height: height), contentsFrame:CGRect(x: -(viewWidth),y: 0, width: width,height: height) , contents: fromViewSnapshot!))
            
            center1 = CGPoint(x: fromView1.center.x - viewWidth, y: fromView1.center.y)
            center2 = CGPoint(x: fromView2.center.x + viewWidth, y: fromView2.center.y)
            
        case .Vertical:
            count = 5
            let width = fromViewFrame.width
            let height = fromViewFrame.height
            let viewHeight = fromViewFrame.height * 0.6
            let frontLayerHeight = fromViewFrame.height - viewHeight
            let backLayerWidth = fromViewFrame.width / count
            
            fromView1.frame = CGRect(x: 0, y: 0, width: width, height: viewHeight)
            fromView2.frame = CGRect(x: 0, y: frontLayerHeight, width: width, height: viewHeight)
            
            var i: CGFloat = 0
            while i < count {
                let frame = CGRect(x: i * backLayerWidth, y: 0, width: backLayerWidth, height: viewHeight)
                let contentFrame = CGRect(x: -(i * backLayerWidth), y: 0, width: width, height: height)
                fromView1.layer.addSublayer(addLayerWith(frame: frame, contentsFrame: contentFrame, contents: fromViewSnapshot!))
                i += 2
            }
            var n: CGFloat = 1
            while n < count {
                let frame = CGRect(x: n * backLayerWidth, y: 0, width: backLayerWidth, height: viewHeight)
                let contentFrame = CGRect(x: -(n * backLayerWidth), y: -(frontLayerHeight), width: width, height: height)
                fromView2.layer.addSublayer(addLayerWith(frame: frame, contentsFrame: contentFrame, contents: fromViewSnapshot!))
                n += 2
            }
            fromView1.layer.addSublayer(addLayerWith(frame: CGRect(x: 0,y: 0, width: width,height: frontLayerHeight), contentsFrame: fromViewFrame, contents: fromViewSnapshot!))
            fromView2.layer.addSublayer(addLayerWith(frame: CGRect(x: 0,y: viewHeight - frontLayerHeight, width: width, height: frontLayerHeight), contentsFrame:CGRect(x: 0,y: -(viewHeight), width: width,height: height) , contents: fromViewSnapshot!))
            
            center1 = CGPoint(x: fromView1.center.x, y: fromView1.center.y - viewHeight)
            center2 = CGPoint(x: fromView2.center.x, y: fromView2.center.y + viewHeight)
            
        default:
            
            let width = fromViewFrame.width
            let height = fromViewFrame.height
            let viewWidth = fromViewFrame.width * 0.6
            let frontLayerWidth = fromViewFrame.width - viewWidth
            let backLayerHeight = fromViewFrame.height / count
            
            fromView1.frame = CGRect(x: 0, y: 0, width: viewWidth, height: height)
            fromView2.frame = CGRect(x: frontLayerWidth, y: 0, width: viewWidth, height: height)
            
            var i: CGFloat = 0
            while i < count {
                let frame = CGRect(x: 0, y: i * backLayerHeight, width: viewWidth, height: backLayerHeight)
                let contentFrame = CGRect(x: 0, y: -(i * backLayerHeight), width: width, height: height)
                fromView1.layer.addSublayer(addLayerWith(frame: frame, contentsFrame: contentFrame, contents: fromViewSnapshot!))
                i += 2
            }
            var n: CGFloat = 1
            while n < count {
                let frame = CGRect(x: 0, y: n * backLayerHeight, width: viewWidth, height: backLayerHeight)
                let contentFrame = CGRect(x: -(frontLayerWidth), y: -(n * backLayerHeight), width: width, height: height)
                fromView2.layer.addSublayer(addLayerWith(frame: frame, contentsFrame: contentFrame, contents: fromViewSnapshot!))
                n += 2
            }
            fromView1.layer.addSublayer(addLayerWith(frame: CGRect(x: 0,y: 0, width: frontLayerWidth,height: height), contentsFrame: fromViewFrame, contents: fromViewSnapshot!))
            fromView2.layer.addSublayer(addLayerWith(frame: CGRect(x: viewWidth - frontLayerWidth,y: 0, width: frontLayerWidth,height: height), contentsFrame:CGRect(x: -(viewWidth),y: 0, width: width,height: height) , contents: fromViewSnapshot!))
            
            center1 = CGPoint(x: fromView1.center.x - viewWidth, y: fromView1.center.y)
            center2 = CGPoint(x: fromView2.center.x + viewWidth, y: fromView2.center.y)
            
        }
        
        containerView.addSubview(fromView1)
        containerView.addSubview(fromView2)
        
        let animator: UIViewPropertyAnimator = UIViewPropertyAnimator.init(duration: duration, curve: .linear, animations: {
            fromView1.center = center1
            fromView2.center = center2
            
        })
        
        animator.addCompletion({ [unowned self] (position) in
            
            let completed = position == .end
            if !completed {
                toView.removeFromSuperview()
            }
            fromView1.removeFromSuperview()
            fromView2.removeFromSuperview()
            if self.transitionCompletion != nil {
                self.transitionCompletion!(completed)
            }
            
        })
        animator.isUserInteractionEnabled = false
        propertyAnimator = animator
        
    }
    
    func addLayerWith(frame: CGRect, contents: UIImage) -> CALayer {
        
        let layer = CALayer()
        layer.frame = frame
        layer.rasterizationScale = contents.scale
        layer.masksToBounds = true
        layer.isDoubleSided = false
        layer.contents = contents.cgImage
        
        return layer
        
    }
    
    func addLayerWith(frame: CGRect, contentsFrame: CGRect, contents: UIImage) -> CALayer {
        
        let contentLayer = CALayer()
        contentLayer.frame = contentsFrame
        contentLayer.rasterizationScale = contents.scale
        contentLayer.masksToBounds = true
        contentLayer.isDoubleSided = false
        contentLayer.contents = contents.cgImage
        
        let layer = CALayer()
        layer.frame = frame
        layer.rasterizationScale = contents.scale
        layer.masksToBounds = true
        layer.isDoubleSided = false
        layer.addSublayer(contentLayer)
        
        return layer
        
    }
    
    
    
}
