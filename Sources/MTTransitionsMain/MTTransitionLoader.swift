//
//  VCTransitionLoader.swift
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

class MTTransitionLoader: NSObject {
    
    class func transitionForType(transitionType: MTTransitionType, transitionSubType:MTTransitionSubType) -> MTTransitionAnimator! {
        if transitionType == .Pull1 {
            return MTPullTransition1(transitionSubType: transitionSubType)
        } else if transitionType == .Push2 {
            return MTPushTransition2(transitionSubType: transitionSubType)
        } else if transitionType == .SwingDoor {
            return MTSwingDoorTransition(transitionSubType: transitionSubType)
        } else if transitionType == .Door2 {
            return MTDoorTransition2(transitionSubType: transitionSubType)
        } else if transitionType == .Door3 {
            return MTDoorTransition3(transitionSubType: transitionSubType)
        } else if transitionType == .Door4 {
            return MTDoorTransition4(transitionSubType: transitionSubType)
        } else if transitionType == .Door5 {
            return MTDoorTransition5(transitionSubType: transitionSubType)
        } else if transitionType == .Folder1 {
            return MTFolderTransition1(transitionSubType: transitionSubType)
        } else if transitionType == .Book1 {
            return MTBookTransition1(transitionSubType: transitionSubType)
        } else if transitionType == .Cube1 {
            return MTCubeTransition1(transitionSubType: transitionSubType)
        } else if transitionType == .Cube2 {
            return MTCubeTransition2(transitionSubType: transitionSubType)
        } else if transitionType == .Cube3 {
            return MTCubeTransition3(transitionSubType: transitionSubType)
        } else if transitionType == .Blinds1 {
            return MTBlindsTransition1(transitionSubType: transitionSubType)
        } else if transitionType == .Blinds2 {
            return MTBlindsTransition2(transitionSubType: transitionSubType)
        } else if transitionType == .Puzzle1 {
            return MTPuzzleTransition1(transitionSubType: transitionSubType)
        } else {
            return MTTransitionAnimator(transitionSubType: transitionSubType)
        }
        
    }
    
}

