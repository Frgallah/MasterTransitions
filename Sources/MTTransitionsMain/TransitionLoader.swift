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

enum TransitionCategory: Int {
    
    case View
    case Layer
    case CoreImage
    case SceneKit
    
}


public enum TransitionType: Int {
    
    case Push2  //0
    case Pull1 //1
    case SwingDoor //2
    case Door2 //3
    case Door3 //4
    case Door4 //5
    case Door5 //6
    case Folder1 //7
    case Book1 //8
    case Cube1 //9
    case Cube2 //10
    case Cube3 //11
    case Blinds1 //12
    case Blinds2 //13
    case Puzzle1 //14
    case Max
}

public enum TransitionSubType: Int {
    
    case RightToLeft
    case LeftToRight
    case BottomToTop
    case TopToBottom
    case Horizontal
    case Vertical
    case HorizontalOpposite
    case VerticalOpposite
    case None
    
}


class TransitionLoader: NSObject {
    
    class func transitionForType(transitionType: TransitionType, transitionSubType:TransitionSubType) -> TransitionAnimator! {
        if transitionType == .Push2 {
            return PushTransition2(transitionSubType: transitionSubType)
        }else if transitionType == .Pull1 {
            return PullTransition1(transitionSubType: transitionSubType)
        } else if transitionType == .SwingDoor {
            return SwingDoorTransition(transitionSubType: transitionSubType)
        } else if transitionType == .Door2 {
            return DoorTransition2(transitionSubType: transitionSubType)
        } else if transitionType == .Door3 {
            return DoorTransition3(transitionSubType: transitionSubType)
        } else if transitionType == .Door4 {
            return DoorTransition4(transitionSubType: transitionSubType)
        } else if transitionType == .Door5 {
            return DoorTransition5(transitionSubType: transitionSubType)
        } else if transitionType == .Folder1 {
            return FolderTransition1(transitionSubType: transitionSubType)
        } else if transitionType == .Book1 {
            return BookTransition1(transitionSubType: transitionSubType)
        } else if transitionType == .Cube1 {
            return CubeTransition1(transitionSubType: transitionSubType)
        } else if transitionType == .Cube2 {
            return CubeTransition2(transitionSubType: transitionSubType)
        } else if transitionType == .Cube3 {
            return CubeTransition3(transitionSubType: transitionSubType)
        } else if transitionType == .Blinds1 {
            return BlindsTransition1(transitionSubType: transitionSubType)
        } else if transitionType == .Blinds2 {
            return BlindsTransition2(transitionSubType: transitionSubType)
        } else if transitionType == .Puzzle1 {
            return PuzzleTransition1(transitionSubType: transitionSubType)
        } else if transitionType == .Max {
            return PuzzleTransition1(transitionSubType: transitionSubType)
        } else {
            return PushTransition2(transitionSubType: transitionSubType)
        }
        
    }
    
}

