//
//  CustomButtonStyle.swift
//  MasterTransitions
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

