//
//  LIHSlider.swift
//  Pods
//
//  Created by Lasith Hettiarachchi on 3/13/16.
//
//

import Foundation

public class LIHSlider: NSObject {
    
    public var sliderImages: [UIImage] = []
    
    public var sliderDescriptions: [String] = []
    public var descriptionColor: UIColor = UIColor.whiteColor()
    public var descriptionBackgroundAlpha: CGFloat = 0.3
    public var descriptionBackgroundColor: UIColor = UIColor.blackColor()
    public var descriptionFont: UIFont = UIFont.systemFontOfSize(15)
    
    public var numberOfLinesInDescription: Int = 2
    
    public var transitionInterval: Double = 3.0
    
    public var customImageView: UIImageView?
    
    public var showPageIndicator: Bool = true
    
    //Sliding options
    public var transitionStyle: UIPageViewControllerTransitionStyle = UIPageViewControllerTransitionStyle.Scroll
    
    public var slidingOrientation: UIPageViewControllerNavigationOrientation = UIPageViewControllerNavigationOrientation.Horizontal
    
    public var sliderNavigationDirection: UIPageViewControllerNavigationDirection = UIPageViewControllerNavigationDirection.Forward
    
    public init(images: [UIImage]) {
        
        self.sliderImages = images
    }
}