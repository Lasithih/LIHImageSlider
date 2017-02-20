//
//  ViewController.swift
//  LIHImageSlider
//
//  Created by Lasith Hettiarachchi on 03/13/2016.
//  Copyright (c) 2016 Lasith Hettiarachchi. All rights reserved.
//

import UIKit
import LIHImageSlider

class ViewController: UIViewController, LIHSliderDelegate {
    
    @IBOutlet weak var slider1Container: UIView!
    @IBOutlet weak var slider2Container: UIView!
    
    
    fileprivate var sliderVc1: LIHSliderViewController!
//    private var sliderVc2: LIHSliderViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Image slider configurations
        let images: [UIImage] = [UIImage(named: "1")!,UIImage(named: "2")!,UIImage(named: "3")!,UIImage(named: "4")!,UIImage(named: "5")!,UIImage(named: "6")!]
        
        
        //Slider One (Top)
        let slider1: LIHSlider = LIHSlider(images: images)
        slider1.sliderDescriptions = ["Image 1 description","Image 2 description","Image 3 description","Image 4 description","Image 5 description","Image 6 description"]
        self.sliderVc1  = LIHSliderViewController(slider: slider1)
        sliderVc1.delegate = self
        self.addChildViewController(self.sliderVc1)
        self.view.addSubview(self.sliderVc1.view)
        self.sliderVc1.didMove(toParentViewController: self)
        
        //Slider Two (Bottom)
//        let slider2: LIHSlider = LIHSlider(images: images)
//            //customizations
//        slider2.transitionInterval = 5.0
//        slider2.transitionStyle = UIPageViewControllerTransitionStyle.PageCurl
//        slider2.slidingOrientation = UIPageViewControllerNavigationOrientation.Vertical
//        slider2.sliderNavigationDirection = UIPageViewControllerNavigationDirection.Reverse
//        slider2.showPageIndicator = false
//        
//        self.sliderVc2  = LIHSliderViewController(slider: slider2)
//        self.addChildViewController(self.sliderVc2)
//        self.view.addSubview(self.sliderVc2.view)
//        self.sliderVc2.didMoveToParentViewController(self)
    }
    
    override func viewDidLayoutSubviews() {
        
        self.sliderVc1!.view.frame = self.slider1Container.frame
//        self.sliderVc2!.view.frame = self.slider2Container.frame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func itemPressedAtIndex(index: Int) {
        
        print("index \(index) is pressed")
    }
}

