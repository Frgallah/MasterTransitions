//
//  CustomButtonStyle.swift
//  MasterTransitions
//
//  Created by Home on 4/19/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class CircleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let layer = self.layer
        layer.masksToBounds = true
        layer.cornerRadius = self.bounds.midX
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let layer = self.layer
        layer.masksToBounds = true
        layer.cornerRadius = self.bounds.midX
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        
    }

}

class RectangleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let layer = self.layer
        layer.masksToBounds = true
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let layer = self.layer
        layer.masksToBounds = true
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        
    }
    
}

