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
    
    public var transitionInterval: Double = 2.0
    
    public var customImageView: UIImageView?
    
    public init(images: [UIImage]) {
        
        self.sliderImages = images
    }
}