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
    
    public var transitionInterval: Double = 3.0
    
    public var customImageView: UIImageView?
    
    public var transitionStyle: UIPageViewControllerTransitionStyle = UIPageViewControllerTransitionStyle.Scroll
    
    public var slidingOrientation: UIPageViewControllerNavigationOrientation = UIPageViewControllerNavigationOrientation.Horizontal
    
    public var sliderNavigationDirection: UIPageViewControllerNavigationDirection = UIPageViewControllerNavigationDirection.Forward
    
    public init(images: [UIImage]) {
        
        self.sliderImages = images
    }
}