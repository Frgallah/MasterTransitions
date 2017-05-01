<div align="center">
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/507810b2/Documentation/Images/MTHeader.png" width="890" alt="Transition"/>
</div>


# MasterTransitions

[![CI Status](https://img.shields.io/travis/rust-lang/rust.svg)](https://github.com/Frgallah/MasterTransitions)
[![Platform](https://img.shields.io/badge/Platform-iOS-blue.svg)](http://cocoapods.org/pods/MasterTransitions)
[![Language](https://img.shields.io/badge/Language-Swift%203.0-orange.svg)](http://cocoapods.org/pods/MasterTransitions)
[![Xcode](https://img.shields.io/badge/Xcode-8.2%2B-blue.svg)](http://cocoapods.org/pods/MasterTransitions)
[![Version](https://img.shields.io/cocoapods/v/MasterTransitions.svg?style=flat)](http://cocoapods.org/pods/MasterTransitions)
[![License](https://img.shields.io/dub/l/vibe-d.svg)](http://cocoapods.org/pods/MasterTransitions)


## Introduction

**MasterTransitions** is a library that contains a collection of custom transitions for view controller. It allows you to create a custom transition with just a few lines of code, making the process of creating custom transitions easy and painless for developers.

## Requirements

- iOS 10.0+
- Xcode 8.2+
- Swift 3

## Installation

### [CocoaPods](http://cocoapods.org). 

To install it, simply add the following lines to your Podfile:

```ruby
use_frameworks!
pod "MasterTransitions"
```
### Manually

Copy `Sources` folder to your Xcode project.

## Usage 

How to use MasterTransitions to create a custom transition:

### Navigation and TabBar Controller



#### Code
 
In the root view controller or the first view controller:
1. Get a reference to your Navigation or TabBar Controller
2. Create a Navigation or TabBar Controller delegate using Navigation or TabBar Controller, transition type and is Interactive as parameters.
3. Optional: in your delegate object
   - set the transition duration
   - set the transition direction
4. Your Done!

Navigation Controller
```swift
// In the root view  controller
override func viewDidLoad() {
super.viewDidLoad()
// 1-  Get a reference to your Navigation Controller
guard let navigationController = self.navigationController else {
return
}
// 2- Create a Navigation Controller delegate with :
let navigationControllerDelegate = NavigationControllerDelegate.init(navigationController: navigationController, transitionType: .Puzzle1, isInteractive: true)
// 3- Optional: in your delegate object
//     - set the transition duration
//     - set the transition direction
navigationControllerDelegate.duration = 1.4
navigationControllerDelegate.transitionSubType = .LeftToRight
}
```
TabBar Controller
```swift
// In the first view  controller
override func viewDidLoad() {
super.viewDidLoad()
// 1-  Get a reference to your TabBar Controller
guard let tabBarController = self.tabBarController else {
return
}
// 2- Create a tabBar Controller delegate with :
let tabBarControllerDelegate = TabBarControllerDelegate.init(tabBarController: tabBarController, transitionType: .Puzzle1, isInteractive: true)
// 3- Optional: in your delegate object
//     - set the transition duration
//     - set the transition direction
tabBarControllerDelegate.duration = 1.4
tabBarControllerDelegate.transitionSubType = .LeftToRight
}
```


#### Interface Builder

if you are using the storyboard only:

1. Drag an Object from the Object Library to your:

navigation controller scene

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/object.png"/>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/navigationObject.png"/>
</div>

or

tabBar controller scene

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/object.png"/>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/tabBarObject.png"/>
</div>

----------

2. In the Custom Class Inspector of the object set its class to:

NavigationControllerDelegate 

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/2b463931/Documentation/Images/naviCustomClass.png"/>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/navigationDelegate.png"/>
</div>

or

TabBarControllerDelegate

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/2b463931/Documentation/Images/tabCustomClass.png"/>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/tabBarDelegate.png"/>
</div>

----------

3. control-drag from the delegate object to:

the navigation controller and set the outlet to navigationController

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/naviDrag1.png"/>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/naviDrag2.png"/>
</div>


or 

the tabBar controller and set the outlet to tabBarController

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/tabDrag1.png"/>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/tabDrag2.png"/>
</div>

----------

4. Optional:
   In the Attributes Inspector of the delegate object
     - set the Type as transition type
     - set the Sub Type as transition direction
     - set the Duration as transition durtion
     - set Is Interactive

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/naviDelegateAtt.png"/>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/tabDelegateAtt.png"/>
</div>

----------

### Modal Controller

#### In code

In the source or presenting view  controller:
1. Create or get a reference to your destination controller
2. set the modal Presentation Style of your destination controller to full screen
3. Create a Modal Controller delegate using the destination controller and a transition type as parameters.
4. Optional:
- make the transition interactive
- set the transition duration
- set the transition direction
5. Your Done!

```swift
// In the source or presenting view  controller:
@IBAction func presentViewControllerModally(_ sender: Any) {
// 1- Create your destination Controller
guard let destinationController = storyboard?.instantiateViewController(withIdentifier: "desVC") as? DestinationViewController else { return }
/* 
or get a reference to your destination controller if you are using prepare for segue function

let destinationController = segue.destination

*/

// 2- set the modal Presentation Style of your destination controller to full screen
destinationController.modalPresentationStyle = .fullScreen
// 3- Create a Modal Controller delegate using the destination controller and a transition type as parameters.
let controllerDelegate = ModalControllerDelegate.init(destinationController: destinationController, transitionType: .Door2)
// 4- Optional:
// - make the transition interactive
// supply a pan gesture if the destination controller view already has a one, if not do not warry about it, the Modal Controller Delegate will create one for you. 
controllerDelegate.addInteractiveToDestinationController(panGesture: nil)
// - set the transition duration
controllerDelegate.duration = 2
// - set the transition direction
controllerDelegate.transitionSubType = .RightToLeft
// - present the destination controller modally
present(destinationController, animated: true, completion: nil)
}
```
#### In Interface Builder

if you using the storyboard only:

1. In the Attributes Inspector of the destination controller set Presentation to Full Screen

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/destinFullScreen.png"/>
</div>

----------

2. Drag an Object from the Object Library to the destination controller scene

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/object.png"/>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/destinationObject.png"/>
</div>

----------

3. In the Custom Class Inspector of the object set its class to ModalControllerDelegate 

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/2b463931/Documentation/Images/modalCustomClass.png"/>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/destinationDelegate.png"/>
</div>

----------

4. control-drag from the delegate object to the destination controller and set the outlet to destinationController

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/destinationDrag1.png"/>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/destinationDrag2.png"/>
</div>

----------

5. Optional:
In the Attributes Inspector of the delegate object
- set the Type as transition type
- set the Sub Type as transition direction
- set the Duration as transition durtion

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/modalDelegateAtt.png"/>
</div>

----------

6. Drag a Pan Gesture Recognizer from the Object Library to the destination controller view.

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/panGesture.png"/>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/modalPanGesture.png"/>
</div>

----------

7. In the Attributes Inspector of the Pan Gesture Recognizer set the Minimum and Maximum Touches to 1

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/panMinMax.png"/>
</div>

----------

8. control-drag from the delegate object to the Pan Gesture Recognizer and set the outlet to panGestureForDismissal

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/modalPanDrag1.png"/>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/713d5e96/Documentation/Images/modalPanDrag2.png"/>
</div>

----------


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

frgallah, frgallah@outlook.com

## Transitions

### Available Transitions

**1. Push 2**

Transition's Directions as Transition SubType

> - RightToLeft
> - LeftToRight
> - BottomToTop
> - TopToBottom


<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/Gifs/push2.gif"  width="200"/>
</div>

----------

**2. Pull 1**

Transition's Directions as Transition SubType

> - RightToLeft
> - LeftToRight
> - BottomToTop
> - TopToBottom


<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/Gifs/pull1.gif" width="200"/>
</div>

----------

**3. Swing Door**

Transition's Directions as Transition SubType

> - RightToLeft
> - LeftToRight
> - BottomToTop
> - TopToBottom


<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/Gifs/swingDoor.gif" width="200"/>
</div>

----------

**4. Door 2**

Transition's Directions as Transition SubType

> - Horizontal
> - Vertical


<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/Gifs/door2.gif" width="200"/>
</div>

----------

**5. Door 3**

Transition's Directions as Transition SubType

> - RightToLeft
> - LeftToRight
> - BottomToTop
> - TopToBottom


<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/Gifs/door3.gif" width="200"/>
</div>

----------

**6. Door 4**

Transition's Directions as Transition SubType

> - Horizontal
> - Vertical


<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/Gifs/door4.gif" width="200"/>
</div>

----------

**7. Door 5**

Transition's Directions as Transition SubType

> - Horizontal
> - Vertical


<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/Gifs/door5.gif" width="200"/>
</div>

----------

**8. Folder 1**

Transition's Directions as Transition SubType

> - Horizontal
> - Vertical


<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/Gifs/folder1.gif" width="200"/>
</div>

----------

**9. Book 1**

Transition's Directions as Transition SubType

> - RightToLeft
> - LeftToRight
> - BottomToTop
> - TopToBottom


<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/Gifs/book1.gif" width="200"/>
</div>

----------

**10. Cube 1**

Transition's Directions as Transition SubType

> - RightToLeft
> - LeftToRight
> - BottomToTop
> - TopToBottom


<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/Gifs/cube1.gif" width="200"/>
</div>

----------

**11. Cube 2**

Transition's Directions as Transition SubType

> - RightToLeft
> - LeftToRight
> - BottomToTop
> - TopToBottom


<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/Gifs/cube2.gif" width="200"/>
</div>

----------

**12. Cube 3**

Transition's Directions as Transition SubType

> - RightToLeft
> - LeftToRight
> - BottomToTop
> - TopToBottom


<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/Gifs/cube3.gif" width="200"/>
</div>

----------

**13. Blinds 1**

Transition's Directions as Transition SubType

> - RightToLeft
> - LeftToRight
> - BottomToTop
> - TopToBottom


<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/Gifs/blinds1.gif" width="200"/>
</div>

----------

**14. Blinds 2**

Transition's Directions as Transition SubType

> - RightToLeft
> - LeftToRight
> - BottomToTop
> - TopToBottom


<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/Gifs/blinds2.gif" width="200"/>
</div>

----------

**15. Puzzle 1**

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/Gifs/puzzle1.gif" width="200"/>
</div>

----------

### Coming soon

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/MoreGifs/more1.gif" width="200"/>
</div>

----------

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/MoreGifs/more2.gif" width="200"/>
</div>

----------

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/MoreGifs/more3.gif" width="200"/>
</div>

----------

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/MoreGifs/more4.gif" width="200"/>
</div>

----------

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/MoreGifs/more5.gif" width="200"/>
</div>

----------

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/MoreGifs/more6.gif" width="200"/>
</div>

----------

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/MoreGifs/more7.gif" width="200"/>
</div>

----------

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/MoreGifs/more8.gif" width="200"/>
</div>

----------

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/MoreGifs/more9.gif" width="200"/>
</div>

----------

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/MoreGifs/more10.gif" width="200"/>
</div>

----------

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/MoreGifs/more11.gif" width="200"/>
</div>

----------

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/MoreGifs/more12.gif" width="200"/>
</div>

----------

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/MoreGifs/more13.gif" width="200"/>
</div>

----------

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/MoreGifs/more14.gif" width="200"/>
</div>

----------

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/MoreGifs/more15.gif" width="200"/>
</div>

----------

<div>
<img src="https://cdn.rawgit.com/Frgallah/MasterTransitions/a6e2bfa1/Documentation/MoreGifs/more16.gif" width="200"/>
</div>

----------


## License

MasterTransitions is available under the MIT license. See the LICENSE file for more info.




