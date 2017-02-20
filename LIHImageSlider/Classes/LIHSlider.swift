//
//  LIHSlider.swift
//  Pods
//
//  Created by Lasith Hettiarachchi on 3/13/16.
//
//

import Foundation

open class LIHSlider: NSObject {
    
    open var sliderImages: [UIImage] = []
    open var sliderDescriptions: [String] = []
    open var descriptionColor: UIColor = UIColor.white
    open var descriptionBackgroundAlpha: CGFloat = 0.3
    open var descriptionBackgroundColor: UIColor = UIColor.black
    open var descriptionFont: UIFont = UIFont.systemFont(ofSize: 15)
    open var numberOfLinesInDescription: Int = 2
    open var transitionInterval: Double = 3.0
    open var customImageView: UIImageView?
    open var showPageIndicator: Bool = true
    open var userInteractionEnabled: Bool = true
    
    //Sliding options
    open var transitionStyle: UIPageViewControllerTransitionStyle = UIPageViewControllerTransitionStyle.scroll
    open var slidingOrientation: UIPageViewControllerNavigationOrientation = UIPageViewControllerNavigationOrientation.horizontal
    open var sliderNavigationDirection: UIPageViewControllerNavigationDirection = UIPageViewControllerNavigationDirection.forward
    
    public init(images: [UIImage]) {
        
        self.sliderImages = images
    }
}
