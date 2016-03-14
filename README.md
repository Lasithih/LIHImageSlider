# LIHImageSlider

[![CI Status](http://img.shields.io/travis/Lasith Hettiarachchi/LIHImageSlider.svg?style=flat)](https://travis-ci.org/Lasith Hettiarachchi/LIHImageSlider)
[![Version](https://img.shields.io/cocoapods/v/LIHImageSlider.svg?style=flat)](http://cocoapods.org/pods/LIHImageSlider)
[![License](https://img.shields.io/cocoapods/l/LIHImageSlider.svg?style=flat)](http://cocoapods.org/pods/LIHImageSlider)
[![Platform](https://img.shields.io/cocoapods/p/LIHImageSlider.svg?style=flat)](http://cocoapods.org/pods/LIHImageSlider)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first

#####Default Slider
```Swift
let images: [UIImage] = [UIImage(named: "1")!,UIImage(named: "2")!,UIImage(named: "3")!,UIImage(named: "4")!,UIImage(named: "5")!,UIImage(named: "6")!]

let slider1: LIHSlider = LIHSlider(images: images)
self.sliderVc1  = LIHSliderViewController(slider: slider1)
self.addChildViewController(self.sliderVc1)
self.view.addSubview(self.sliderVc1.view)
self.sliderVc1.didMoveToParentViewController(self)
```

#####Customized Slider
```Swift
let slider2: LIHSlider = LIHSlider(images: images)
    //customizations
slider2.transitionInterval = 5.0
slider2.transitionStyle = UIPageViewControllerTransitionStyle.PageCurl
slider2.slidingOrientation = UIPageViewControllerNavigationOrientation.Vertical
slider2.sliderNavigationDirection = UIPageViewControllerNavigationDirection.Reverse
slider2.showPageIndicator = false
        
self.sliderVc2  = LIHSliderViewController(slider: slider2)
self.addChildViewController(self.sliderVc2)
self.view.addSubview(self.sliderVc2.view)
self.sliderVc2.didMoveToParentViewController(self)
```

## Requirements
iOS 7+

## Installation

LIHImageSlider is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "LIHImageSlider"
```

## Author

Lasith Hettiarachchi, lasithih@yahoo.com

## License

LIHImageSlider is available under the MIT license. See the LICENSE file for more info.
