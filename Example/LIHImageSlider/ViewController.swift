//
//  ViewController.swift
//  LIHImageSlider
//
//  Created by Lasith Hettiarachchi on 03/13/2016.
//  Copyright (c) 2016 Lasith Hettiarachchi. All rights reserved.
//

import UIKit
import LIHImageSlider

class ViewController: UIViewController {
    
    @IBOutlet weak var container: UIView!
    private var sliderVc: LIHSliderViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Image slider configurations
        LIHSlider.sliderImages.append(UIImage(named: "1")!)
        LIHSlider.sliderImages.append(UIImage(named: "2")!)
        LIHSlider.sliderImages.append(UIImage(named: "3")!)
        LIHSlider.sliderImages.append(UIImage(named: "4")!)
        LIHSlider.sliderImages.append(UIImage(named: "5")!)
        LIHSlider.sliderImages.append(UIImage(named: "6")!)
        
        LIHSlider.transitionInterval = 3.0 //default is 2.0
        
        let sliderViewController = LIHSliderViewController()
        self.sliderVc = sliderViewController
        self.addChildViewController(sliderViewController)
        self.view.addSubview(sliderViewController.view)
        sliderViewController.didMoveToParentViewController(self)
    }
    
    override func viewDidLayoutSubviews() {
        
        self.sliderVc!.view.frame = self.container.frame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

