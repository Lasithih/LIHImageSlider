# LIHImageSlider

[![CI Status](http://img.shields.io/travis/Lasith Hettiarachchi/LIHImageSlider.svg?style=flat)](https://travis-ci.org/Lasith Hettiarachchi/LIHImageSlider)
[![Version](https://img.shields.io/cocoapods/v/LIHImageSlider.svg?style=flat)](http://cocoapods.org/pods/LIHImageSlider)
[![License](https://img.shields.io/cocoapods/l/LIHImageSlider.svg?style=flat)](http://cocoapods.org/pods/LIHImageSlider)
[![Platform](https://img.shields.io/cocoapods/p/LIHImageSlider.svg?style=flat)](http://cocoapods.org/pods/LIHImageSlider)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first

#####Default Slider
<p><img src="https://2.bp.blogspot.com/-rMzLaIDW0D8/VuZug9qrMPI/AAAAAAAACuo/sMChPhCiN4UVoBeIi5Al3rpqq2WYbT8UA/s320/LIHImageSlider2_1.gif"/></p>
```Swift
let images: [UIImage] = [UIImage(named: "1")!,UIImage(named: "2")!,UIImage(named: "3")!,UIImage(named: "4")!,UIImage(named: "5")!,UIImage(named: "6")!]

let slider1: LIHSlider = LIHSlider(images: images)
slider1.sliderDescriptions = ["Image 1 description","Image 2 description","Image 3 description","Image 4 description","Image 5 description","Image 6 description"]
self.sliderVc1  = LIHSliderViewController(slider: slider1)
sliderVc1.delegate = self
self.addChildViewController(self.sliderVc1)
self.view.addSubview(self.sliderVc1.view)
self.sliderVc1.didMoveToParentViewController(self)
```

#####Customized Slider
<p><img src="https://1.bp.blogspot.com/-ZDlRb25t914/VuZug5m_K5I/AAAAAAAACus/f-jd6LJJy2kuO_FkQNrWfU1vS0yP8IqXg/s320/LIHImageSlider2_2.gif"/></p>
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

#####Item Click
Implement `LIHSliderDelegate` 
```Swift
func itemPressedAtIndex(index index: Int) {

}
```

#####List of all properties
```Swift
public var sliderImages: [UIImage]
public var sliderDescriptions: [String] //leave empty to remove description
public var descriptionColor: UIColor  //default is white
public var descriptionBackgroundAlpha: CGFloat //default is 0.3
public var descriptionBackgroundColor: UIColor //default is black
public var descriptionFont: UIFont //default is system font with size 15
public var numberOfLinesInDescription: Int //default is 2
public var transitionInterval: Double //default is 3.0
public var customImageView: UIImageView?
public var showPageIndicator: Bool //default is true
public var userInteractionEnabled: Bool //default is true

//Sliding options
public var transitionStyle: UIPageViewControllerTransitionStyle = UIPageViewControllerTransitionStyle.Scroll
public var slidingOrientation: UIPageViewControllerNavigationOrientation = UIPageViewControllerNavigationOrientation.Horizontal
public var sliderNavigationDirection: UIPageViewControllerNavigationDirection = UIPageViewControllerNavigationDirection.Forward
```


## Requirements
iOS 7+

## Installation

LIHImageSlider is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LIHImageSlider'
```

### ChangeLog

v1.0.6
######User interaction controlls added

v1.0.5
######Updated to Swift 3


## Author

Lasith Hettiarachchi, lasithih@yahoo.com

## License

LIHImageSlider is available under the MIT license. See the LICENSE file for more info.
