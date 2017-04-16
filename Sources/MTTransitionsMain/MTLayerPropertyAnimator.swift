//
//  MTLayerPropertyAnimator.swift
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

class MTLayerPropertyAnimator: UIViewPropertyAnimator {
    
    var pausedTime: Double = 0
    
    var animationUpdated: (() -> ())?
    
    var mainlayer: CALayer?
    
    override var fractionComplete: CGFloat {
        
        willSet {
            
            if let layer = self.mainlayer  {
                let fraction = Double(newValue)
                layer.timeOffset = pausedTime + (duration * fraction)
           
            }
    
        }

    }
    
    override func startAnimation() {
        
        if let layer = self.mainlayer  {
            layer.speed = 1
        }
        super.startAnimation()
        
    }
    
    override func startAnimation(afterDelay delay: TimeInterval) {
        if let layer = self.mainlayer  {
            layer.beginTime = delay
            layer.speed = 1
        }
        super.startAnimation(afterDelay: delay)
        
    }
    
    override func pauseAnimation() {
        if let layer = self.mainlayer  {
            pauseLayerAnimation(layer: layer)
        }
        super.pauseAnimation()
        
        
    }
    
    override func stopAnimation(_ withoutFinishing: Bool) {
        if let layer = self.mainlayer  {
            if withoutFinishing {
                layer.speed = 0
            }
        }
        
        super.stopAnimation(withoutFinishing)
    }
    
    override func finishAnimation(at finalPosition: UIViewAnimatingPosition) {
        if let layer = self.mainlayer  {
            let speed: Float = finalPosition == .start ? -1 : 1
            layer.speed = speed
        }
        super.finishAnimation(at: finalPosition)
    }
    
    override func continueAnimation(withTimingParameters parameters: UITimingCurveProvider?, durationFactor: CGFloat) {
   
        if let layer = self.mainlayer  {
            let speed: Float = isReversed ? -1 : 1
            resumeLayerAnimation(layer: layer, speed: speed)

        }
        
        super.continueAnimation(withTimingParameters: parameters, durationFactor: durationFactor)
        
    }
    
    func startInteractiveAnimation() {
        pauseAnimation()
    }
    
    func pauseLayerAnimation(layer: CALayer) {
        let pausedTime: Double = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0
        layer.timeOffset = pausedTime
        self.pausedTime = pausedTime
        
    }
    
    func resumeLayerAnimation(layer: CALayer, speed: Float) {
        if speed < 0 {
            if let transitionUpdate = self.animationUpdated {
                transitionUpdate()
            }
            layer.speed = speed;
            layer.beginTime = CACurrentMediaTime();
        } else {
            let pausedTime: Double = layer.timeOffset
            layer.speed = speed
            layer.timeOffset = 0.0
            layer.beginTime = 0.0
            let timeSincePause: Double = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime;
            layer.beginTime = timeSincePause;
        }
        
        
    }
    
    
}
