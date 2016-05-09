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
    private var lblDescription: UILabel?
    private var labelContainer: UIView?
    
    var index: Int = 0
    var image: UIImage?
    var desc: String?
    
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
        self.button.addTarget(self, action: #selector(LIHSliderItemViewController.pressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.button)
        self.imageView.frame = self.view.frame
        self.button.frame = self.imageView.frame
        
        
        
        if self.slider.sliderDescriptions.count > 0 {
            self.lblDescription = UILabel()
            self.lblDescription?.numberOfLines = self.slider.numberOfLinesInDescription
            self.lblDescription?.textColor = self.slider.descriptionColor
            let lblHeight = self.view.frame.size.height / 2
            let lblY = self.view.frame.origin.y + lblHeight
            self.lblDescription?.font = self.slider.descriptionFont
            self.lblDescription?.frame = CGRectMake(self.view.frame.origin.x+10, lblY, self.view.frame.size.width-10, lblHeight)
            
            self.labelContainer = UIView()
            self.labelContainer?.backgroundColor = self.slider.descriptionBackgroundColor
            self.labelContainer?.alpha = self.slider.descriptionBackgroundAlpha
            self.labelContainer?.frame = CGRectMake(self.view.frame.origin.x, lblY, self.view.frame.size.width, lblHeight)
            
            self.view.addSubview(self.labelContainer!)
            self.view.addSubview(self.lblDescription!)
        }
        
        self.applyConfig()
    }
    
    override func viewDidLayoutSubviews() {
        
        self.imageView.frame = self.view.frame
        self.button.frame = self.imageView.frame
        let lblHeight = self.view.frame.size.height / 2
        let lblY = self.view.frame.origin.y + lblHeight
        self.lblDescription?.frame = CGRectMake(self.view.frame.origin.x+10, lblY, self.view.frame.size.width-10, lblHeight)
        self.labelContainer?.frame = CGRectMake(self.view.frame.origin.x, lblY, self.view.frame.size.width, lblHeight)
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
        
        if let description = self.desc {
            self.lblDescription?.text = description
        } else {
            self.labelContainer?.hidden = true
        }
    }
    
    internal func pressed(sender:UIButton) {
        
        self.delegate?.itemPressedAtIndex(self.index)
    }

}
