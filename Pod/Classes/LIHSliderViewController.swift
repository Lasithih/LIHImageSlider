//
//  LIHSliderViewController.swift
//  Pods
//
//  Created by Lasith Hettiarachchi on 3/13/16.
//
//

import UIKit

@objc public protocol LIHSliderDelegate {
    
    func itemPressedAtIndex(index index: Int)
}

public class LIHSliderViewController: UIViewController, LIHSliderItemDelegate {

    //@IBOutlet weak var pageControl: UIPageControl!
    private var pageControl: UIPageControl!
    private var pageController: UIPageViewController!
    private var currentIndex: Int = 0 {
        didSet {
            self.pageControl.currentPage = currentIndex
        }
    }
    private var pageTimer: NSTimer?
    
    private var slider: LIHSlider!
    
    public init(slider: LIHSlider) {
        super.init(nibName: nil, bundle: nil)
        
        self.slider = slider
    }
    
    public var delegate: LIHSliderDelegate?

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        self.view.backgroundColor = UIColor.orangeColor()
        self.killTimer()
        self.activateTimer()
        
        self.pageControl = UIPageControl()
        if self.slider.showPageIndicator {
            self.view.addSubview(self.pageControl)
        }
        
        
        self.initializePager()
        self.pageController.view.backgroundColor = UIColor.blueColor()
    }
    
    public override func viewDidLayoutSubviews() {
        
        self.pageControl.center = CGPointMake(UIScreen.mainScreen().bounds.size.width/2, self.view.frame.size.height - 20)
    }
    
    //MARK - Private methods
    private func initializePager() {
        
        //Initialize page view controller
        self.pageControl.numberOfPages = self.slider.sliderImages.count
        self.pageControl.currentPage = 0
        
        pageController = UIPageViewController(transitionStyle: self.slider.transitionStyle, navigationOrientation: self.slider.slidingOrientation, options: nil)
        pageController.dataSource = self
        pageController.delegate = self
        
        let startingViewController: LIHSliderItemViewController = contentViewController(atIndex: currentIndex)
        pageController.setViewControllers([startingViewController], direction: .Forward, animated: false, completion: nil)
        
        self.view.addSubview(self.pageController.view)
        self.view.bringSubviewToFront(self.pageControl)
        pageController.didMoveToParentViewController(self)
        
        for sview in pageController.view.subviews {
            
            if sview.isKindOfClass(UIScrollView) {
                (sview as! UIScrollView).delegate = self
            }
        }
        
        
        self.killTimer()
        self.activateTimer()
    }
    
    private func setConstraints() {
        
        let top = NSLayoutConstraint(item: self.pageController.view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        
        let bottom = NSLayoutConstraint(item: self.pageController.view, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        
        let left = NSLayoutConstraint(item: self.pageController.view, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0)
        
        let right = NSLayoutConstraint(item: self.pageController.view, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)
        
        self.view.addConstraints([top,bottom,left,right])
    }
    
    private func activateTimer() {
        
        self.pageTimer = NSTimer.scheduledTimerWithTimeInterval(self.slider.transitionInterval, target: self, selector: #selector(LIHSliderViewController.pageSwitchTimer(_:)), userInfo: nil, repeats: true)
    }
    
    private func killTimer() {
        self.pageTimer?.invalidate()
        self.pageTimer = nil
        
    }
    
    func pageSwitchTimer(sender: AnyObject) {
        
        if currentIndex == self.slider.sliderImages.count - 1 {
            self.pageController.setViewControllers([self.contentViewController(atIndex: 0)], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: { (complete) -> Void in
                self.currentIndex = 0
            })
        } else {
            self.pageController.setViewControllers([self.contentViewController(atIndex: self.currentIndex+1)], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: { (complete) -> Void in
                self.currentIndex = self.currentIndex + 1
            })
        }
    }
    
    
    
    private func contentViewController(atIndex index: Int) -> LIHSliderItemViewController! {
        if self.slider.sliderImages.count == 0 || index >= self.slider.sliderImages.count {
            self.pageControl.hidden = true
            return nil
        }
        self.pageControl.hidden = false
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
    
    
    func itemPressedAtIndex(index: Int) {
        
        self.delegate?.itemPressedAtIndex(index: index)
    }

}

extension LIHSliderViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    public func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! LIHSliderItemViewController
        let index = vc.index
        
        if index == self.slider.sliderImages.count - 1 {
            return self.contentViewController(atIndex: 0)
        }
        
        return self.contentViewController(atIndex: index + 1)
    }
    
    public func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! LIHSliderItemViewController
        let index = vc.index
        
        if index == 0 {
            return self.contentViewController(atIndex: self.slider.sliderImages.count - 1)
        }
        
        return self.contentViewController(atIndex: index - 1)
    }
    
    public func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if !completed {
            return
        }
        
        self.currentIndex = (pageController?.viewControllers?.first as! LIHSliderItemViewController).index
        
    }
}

extension LIHSliderViewController: UIScrollViewDelegate {
    
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        self.killTimer()
    }
    
    public func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        self.killTimer()
        self.activateTimer()
    }

}
