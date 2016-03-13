//
//  LIHSliderViewController.swift
//  Pods
//
//  Created by Lasith Hettiarachchi on 3/13/16.
//
//

import UIKit

public class LIHSliderViewController: UIViewController {

    //@IBOutlet weak var pageControl: UIPageControl!
    private var pageControl: UIPageControl!
    private var pageController: UIPageViewController!
    private var currentIndex: Int = 0 {
        didSet {
            self.pageControl.currentPage = currentIndex
        }
    }
    private var pageTimer: NSTimer?
    
    override public func viewDidLoad() {
        
        self.killTimer()
        self.activateTimer()
        
        self.pageControl = UIPageControl()
        self.view.addSubview(self.pageControl)
        
        self.initializePager()
    }
    
    public override func viewDidLayoutSubviews() {
        
        self.pageControl.center = CGPointMake(UIScreen.mainScreen().bounds.size.width/2, self.view.frame.size.height - 20)
        
        self.pageController.view.frame = self.view.frame
    }
    
    //MARK - Private methods
    private func initializePager() {
        
        //Initialize page view controller
        self.pageControl.numberOfPages = LIHSlider.sliderImages.count
        self.pageControl.currentPage = 0
        
        
        pageController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageController.dataSource = self
        pageController.delegate = self
        
        let startingViewController: LIHSliderItemViewController = contentViewController(atIndex: currentIndex)
        pageController.setViewControllers([startingViewController], direction: .Forward, animated: false, completion: nil)
        
        
        self.addChildViewController(pageController)
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
    
    private func activateTimer() {
        
        self.pageTimer = NSTimer.scheduledTimerWithTimeInterval(LIHSlider.transitionInterval, target: self, selector: "pageSwitchTimer:", userInfo: nil, repeats: true)
    }
    
    private func killTimer() {
        self.pageTimer?.invalidate()
        self.pageTimer = nil
    }
    
    func pageSwitchTimer(sender: AnyObject) {
        
        if currentIndex == LIHSlider.sliderImages.count - 1 {
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
        if LIHSlider.sliderImages.count == 0 || index >= LIHSlider.sliderImages.count {
            self.pageControl.hidden = true
            return nil
        }
        self.pageControl.hidden = false
        let contentvc: LIHSliderItemViewController? = LIHSliderItemViewController()
        if let pageContentvc = contentvc {
            
            pageContentvc.image = LIHSlider.sliderImages[index]
            pageContentvc.index = index
            return pageContentvc
        }
        
        return nil
    }

}

extension LIHSliderViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    public func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! LIHSliderItemViewController
        let index = vc.index
        
        if index == LIHSlider.sliderImages.count - 1 {
            return self.contentViewController(atIndex: 0)
        }
        
        return self.contentViewController(atIndex: index + 1)
    }
    
    public func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! LIHSliderItemViewController
        let index = vc.index
        
        if index == 0 {
            return self.contentViewController(atIndex: LIHSlider.sliderImages.count - 1)
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
