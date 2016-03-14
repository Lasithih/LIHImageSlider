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
        let images: [UIImage] = [UIImage(named: "1")!,UIImage(named: "2")!,UIImage(named: "3")!,UIImage(named: "4")!,UIImage(named: "5")!,UIImage(named: "6")!]
        
        let slider: LIHSlider = LIHSlider(images: images)
        
        slider.transitionInterval = 3.0 //default is 2.0
        
        let sliderViewController = LIHSliderViewController(slider: slider)
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

