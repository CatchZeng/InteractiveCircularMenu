# InteractiveCircularMenu

[![Version](https://img.shields.io/cocoapods/v/InteractiveCircularMenu.svg?style=flat)](https://cocoapods.org/pods/InteractiveCircularMenu)
[![License](https://img.shields.io/cocoapods/l/InteractiveCircularMenu.svg?style=flat)](https://cocoapods.org/pods/InteractiveCircularMenu)
[![Platform](https://img.shields.io/cocoapods/p/InteractiveCircularMenu.svg?style=flat)](https://cocoapods.org/pods/InteractiveCircularMenu)

Interactive, springback, customizable(color, width, speed, angles) circular menu.

## Example

![](https://raw.githubusercontent.com/CatchZeng/InteractiveCircularMenu/master/menu.gif)

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation

InteractiveCircularMenu is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'InteractiveCircularMenu'
```

## Concept

### StartAngleOffset

![](https://raw.githubusercontent.com/CatchZeng/InteractiveCircularMenu/master/startAngleOffset.png)

### SpeedRatio

Interactive speed, default is 1.0 .

### CircularWidth

![](https://raw.githubusercontent.com/CatchZeng/InteractiveCircularMenu/master/circularWidth.png)

### SpacingAngle

![](https://raw.githubusercontent.com/CatchZeng/InteractiveCircularMenu/master/spacingAngle.png)

### MaxAngle

The max angle you can scroll.

### MinAngle

The min angle you can scroll.

### MaxSpringbackAngle

The max angle for springback, default is maxAngle-spacingAngle.

### MinSpringbackAngle

The min angle for springback, default is minAngle+spacingAngle.

## Usage

### Init InteractiveCircularMenu and set dataSource & delegate

```swift
menuView.dataSource = self
menuView.delegate = self
```

### Set menu color your like.

```swift
menuView.menuColor = UIColor.white
```

### Implement dataSource & delegate

```swift
extension ViewController: InteractiveCircularMenuDataSource {
    func numberOfItems(in menu: InteractiveCircularMenu) -> Int {
        return items.count
    }

    func menu(_ menu: InteractiveCircularMenu, itemAt index: Int) -> CircularMenuItem {
        return items[index]
    }
}

extension ViewController: InteractiveCircularMenuDelegate {
    func menu(_ menu: InteractiveCircularMenu, didSelectAt index: Int) {
        AlertControllerBuilder(title: "Tip",
                               message: "Click:\(index+1)").addAction(title: "OK") { (_) in
        }.build().show()
    }

    func circularWidth(in menu: InteractiveCircularMenu) -> CGFloat {
        return 80
    }

    func menu(_ menu: InteractiveCircularMenu, itemSizeAt index: Int) -> CGSize {
        let width = circularWidth(in: menu)
        return CGSize(width: width*0.9, height: width*0.9)
    }

    func startAngleOffset(_ menu: InteractiveCircularMenu) -> CGFloat {
        return 60
    }

    func spacingAngle(_ menu: InteractiveCircularMenu) -> CGFloat {
        return 30
    }

    func maxAngle(_ menu: InteractiveCircularMenu) -> CGFloat {
        return startAngleOffset(menu) + 2*spacingAngle(menu)
    }

    func minAngle(_ menu: InteractiveCircularMenu) -> CGFloat {
        let offset = startAngleOffset(menu)
        let spacing = spacingAngle(menu)
        return offset-spacing*CGFloat(items.count-1)
    }
}

```


## Author

catchzeng, catchzenghh@gmail.com

## License

InteractiveCircularMenu is available under the MIT license. See the LICENSE file for more info.
