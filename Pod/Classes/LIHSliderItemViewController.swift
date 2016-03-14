//
//  LIHSliderItemViewController.swift
//  Pods
//
//  Created by Lasith Hettiarachchi on 3/13/16.
//
//

import UIKit

class LIHSliderItemViewController: UIViewController {

    private var imageView: UIImageView!
    
    var index: Int = 0
    var image: UIImage?
    
    private var slider: LIHSlider!
    
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
        }
        self.view.addSubview(self.imageView)
        self.imageView.frame = self.view.frame
        
        self.applyConfig()
    }
    
    override func viewDidLayoutSubviews() {
        
        self.imageView.frame = self.view.frame
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

}
