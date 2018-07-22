//
//  ViewController.swift
//  PageViewTest
//
//  Created by Pranavan on 7/21/18.
//  Copyright © 2018 Pranavan. All rights reserved.
//

import UIKit

import UIKit

class PageViewController: UIViewController {
    
    @IBOutlet weak var PageControl: UIPageControl!
    
    var pageViewController: UIPageViewController?
    var images = ["01","03","02","04","05","06"]
    var pendingIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPageViewController()
        setupPageControll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createPageViewController() {
        let pageController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        
        pageController.isDoubleSided = true
        pageController.dataSource = self
        pageController.delegate = self
        
        if images.count > 1{
            let firstController = getContentViewController(withIndex: 0)!
            let secondController = getContentViewController(withIndex: 1)!
            let contentControllers = [firstController,secondController]
            pageController.setViewControllers(contentControllers, direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
            
        }
        
        pageViewController = pageController
        self.addChildViewController(pageViewController!)
        self.view.insertSubview(pageViewController!.view, at: 0)
        pageViewController!.didMove(toParentViewController: self)
        
    }
    
    //Setup Pagination Icons and count
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return images.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func setupPageControll(){
        let apperance = UIPageControl.appearance()
        apperance.pageIndicatorTintColor = UIColor.gray
        apperance.currentPageIndicatorTintColor = UIColor.white
        apperance.backgroundColor = UIColor.clear
    }
    
    func currentControllerIndex() -> Int{
        let pageItemController = self.currentConroller()
        
        if let controller = pageItemController as? ContentView {
            return controller.itemIndex
        }
        return -1
    }
    
    ///////////////////////////////////////////////
    
    func currentConroller() -> UIViewController?{
        if (self.pageViewController?.viewControllers?.count)! > 0{
            return self.pageViewController?.viewControllers![0]
        }
        
        return nil
    }
    
    func getContentViewController(withIndex index: Int) -> ContentView? {
        if index < images.count{
            let contentVC = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentView
            contentVC.itemIndex = index
            contentVC.imageString = self.images[index]
            
            return contentVC
        }
        
        return nil
    }
    
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = (pendingViewControllers.first as! ContentView).itemIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let contentVC = viewController as! ContentView
        
        if contentVC.itemIndex > 0 {
            return getContentViewController(withIndex: contentVC.itemIndex - 1)
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let contentVC = viewController as! ContentView
        if contentVC.itemIndex + 1 < images.count {
            return getContentViewController(withIndex: contentVC.itemIndex + 1)
        }
        
        return nil
    }
}
