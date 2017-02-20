//
//  LIHSliderViewController.swift
//  Pods
//
//  Created by Lasith Hettiarachchi on 3/13/16.
//
//

import UIKit

@objc public protocol LIHSliderDelegate {
    
    func itemPressedAtIndex(index: Int)
}

open class LIHSliderViewController: UIViewController, LIHSliderItemDelegate {

    //@IBOutlet weak var pageControl: UIPageControl!
    fileprivate var pageControl: UIPageControl!
    fileprivate var pageController: UIPageViewController!
    fileprivate var currentIndex: Int = 0 {
        didSet {
            self.pageControl.currentPage = currentIndex
        }
    }
    fileprivate var pageTimer: Timer?
    
    fileprivate var slider: LIHSlider!
    
    public init(slider: LIHSlider) {
        super.init(nibName: nil, bundle: nil)
        
        self.slider = slider
    }
    
    open var delegate: LIHSliderDelegate?

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        self.view.backgroundColor = UIColor.orange
        self.killTimer()
        self.activateTimer()
        
        self.pageControl = UIPageControl()
        if self.slider.showPageIndicator {
            self.view.addSubview(self.pageControl)
        }
        
        
        self.initializePager()
        self.pageController.view.backgroundColor = UIColor.blue
    }
    
    open override func viewDidLayoutSubviews() {
        
        self.pageControl.center = CGPoint(x: UIScreen.main.bounds.size.width/2, y: self.view.frame.size.height - 20)
    }
    
    //MARK - Private methods
    fileprivate func initializePager() {
        
        //Initialize page view controller
        self.pageControl.numberOfPages = self.slider.sliderImages.count
        self.pageControl.currentPage = 0
        
        pageController = UIPageViewController(transitionStyle: self.slider.transitionStyle, navigationOrientation: self.slider.slidingOrientation, options: nil)
        pageController.dataSource = self
        pageController.delegate = self
        
        if !self.slider.userInteractionEnabled {
            self.removeSwipeGesture()
        }
        
        let startingViewController: LIHSliderItemViewController = contentViewController(atIndex: currentIndex)
        pageController.setViewControllers([startingViewController], direction: .forward, animated: false, completion: nil)
        
        self.view.addSubview(self.pageController.view)
        self.view.bringSubview(toFront: self.pageControl)
        pageController.didMove(toParentViewController: self)
        
        for sview in pageController.view.subviews {
            
            if sview.isKind(of: UIScrollView.self) {
                (sview as! UIScrollView).delegate = self
            }
        }
        
        
        self.killTimer()
        self.activateTimer()
    }
    
    fileprivate func removeSwipeGesture(){
        for view in self.pageController.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }
    
    fileprivate func setConstraints() {
        
        let top = NSLayoutConstraint(item: self.pageController.view, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        
        let bottom = NSLayoutConstraint(item: self.pageController.view, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        
        let left = NSLayoutConstraint(item: self.pageController.view, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0)
        
        let right = NSLayoutConstraint(item: self.pageController.view, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0)
        
        self.view.addConstraints([top,bottom,left,right])
    }
    
    fileprivate func activateTimer() {
        
        self.pageTimer = Timer.scheduledTimer(timeInterval: self.slider.transitionInterval, target: self, selector: #selector(LIHSliderViewController.pageSwitchTimer(_:)), userInfo: nil, repeats: true)
    }
    
    fileprivate func killTimer() {
        self.pageTimer?.invalidate()
        self.pageTimer = nil
        
    }
    
    func pageSwitchTimer(_ sender: AnyObject) {
        
        if currentIndex == self.slider.sliderImages.count - 1 {
            self.pageController.setViewControllers([self.contentViewController(atIndex: 0)], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: { (complete) -> Void in
                self.currentIndex = 0
            })
        } else {
            self.pageController.setViewControllers([self.contentViewController(atIndex: self.currentIndex+1)], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: { (complete) -> Void in
                self.currentIndex = self.currentIndex + 1
            })
        }
    }
    
    
    
    fileprivate func contentViewController(atIndex index: Int) -> LIHSliderItemViewController! {
        if self.slider.sliderImages.count == 0 || index >= self.slider.sliderImages.count {
            self.pageControl.isHidden = true
            return nil
        }
        self.pageControl.isHidden = false
        let contentvc: LIHSliderItemViewController? = LIHSliderItemViewController(slider: self.slider)
        if let pageContentvc = contentvc {
            
            if self.slider.sliderImages.count > index {
                pageContentvc.image = self.slider.sliderImages[index]
            }
            if self.slider.sliderDescriptions.count > index {
                pageContentvc.desc = self.slider.sliderDescriptions[index]
            }
            
            pageContentvc.index = index
            pageContentvc.delegate = self
            return pageContentvc
        }
        
        return nil
    }
    
    
    func itemPressedAtIndex(_ index: Int) {
        
        self.delegate?.itemPressedAtIndex(index: index)
    }

}

extension LIHSliderViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! LIHSliderItemViewController
        let index = vc.index
        
        if index == self.slider.sliderImages.count - 1 {
            return self.contentViewController(atIndex: 0)
        }
        
        return self.contentViewController(atIndex: index + 1)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! LIHSliderItemViewController
        let index = vc.index
        
        if index == 0 {
            return self.contentViewController(atIndex: self.slider.sliderImages.count - 1)
        }
        
        return self.contentViewController(atIndex: index - 1)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if !completed {
            return
        }
        
        self.currentIndex = (pageController?.viewControllers?.first as! LIHSliderItemViewController).index
        
    }
}

extension LIHSliderViewController: UIScrollViewDelegate {
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        self.killTimer()
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        self.killTimer()
        self.activateTimer()
    }

}
