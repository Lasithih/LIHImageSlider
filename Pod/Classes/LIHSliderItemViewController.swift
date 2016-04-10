//
//  LIHSliderItemViewController.swift
//  Pods
//
//  Created by Lasith Hettiarachchi on 3/13/16.
//
//

import UIKit

@objc protocol LIHSliderItemDelegate {
    
    func itemPressedAtIndex(index: Int)
}

class LIHSliderItemViewController: UIViewController {
    
    private var imageView: UIImageView!
    private var button: UIButton!
    
    var index: Int = 0
    var image: UIImage?
    
    private var slider: LIHSlider!
    
    var delegate: LIHSliderItemDelegate?
    
    init(slider: LIHSlider){
        super.init(nibName: nil, bundle: nil)
        self.slider = slider
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageview = self.slider.customImageView {
            self.imageView = imageview
        } else {
            self.imageView = UIImageView()
            self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        }
        self.button = UIButton()
        self.button.addTarget(self, action: Selector("pressed:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.button)
        self.imageView.frame = self.view.frame
        self.button.frame = self.imageView.frame
        
        self.applyConfig()
    }
    
    override func viewDidLayoutSubviews() {
        
        self.imageView.frame = self.view.frame
        self.button.frame = self.imageView.frame
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func applyConfig() {
        
        let defaultImage: UIImage? = nil
        
        if let img = self.image {
            
            self.imageView.image = img
            
        } else {
            self.imageView.image = defaultImage
        }
    }
    
    internal func pressed(sender:UIButton) {
        
        self.delegate?.itemPressedAtIndex(self.index)
    }

}
