//
//  AppIntroPageViewController.swift
//  AppIntro
//
//  Created by Shantaram Kokate on 11/14/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit

class AppIntroPageViewController: UIViewController {
    
    // MARK: - Properties
    private var pageController: UIPageViewController!
    var pages = [UIViewController]()
    let initialPage = 0
    let viewModel = AppIntroViewModel()
    let pageControl = UIPageControl()

    
    /*  var pageControl: UIPageControl {
     let pageControl = UIPageControl()
     pageControl.frame = CGRect()
     pageControl.currentPageIndicatorTintColor = UIColor.black
     pageControl.pageIndicatorTintColor = UIColor.lightGray
     pageControl.currentPage = initialPage
     pageControl.translatesAutoresizingMaskIntoConstraints = false
     return pageControl
     }
     
     var skipButton: UIButton {
     let button = UIButton()
     button.translatesAutoresizingMaskIntoConstraints = false
     button.backgroundColor = UIColor.black
     button.setTitle("Skip", for: .normal)
     button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
     return button
     } */
    
    
    var pgaeIndicatorColor: UIColor = UIColor.gray {
        didSet {
            configureUI()
        }
    }
    
    var pgaeCurrentIndicatorColor: UIColor = UIColor.black {
        didSet {
            configureUI()
        }
    }
    
    var numberOfPages: Int {
        return self.viewModel.tutorialList.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        
        
    }
}

// MARK: - Configure UI

extension AppIntroPageViewController {
    
    private func configureUI() {
        setupPageViewController()
        setupPageControl()
        setupSkipButton()
        setScrollViewDelegate()
        
    }
    
    private func setupPageControl() {
        
        pageControl.frame = CGRect()
        pageControl.currentPageIndicatorTintColor = pgaeCurrentIndicatorColor
        pageControl.pageIndicatorTintColor = pgaeIndicatorColor
        pageControl.currentPage = initialPage
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.pageControl)
        self.pageControl.numberOfPages = numberOfPages
        
        self.pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -90).isActive = true
        self.pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20).isActive = true
        self.pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    private func setupPageViewController() {
        self.pages = viewModel.orderedViewControllers
        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController.delegate = self
        pageController.dataSource = self
        self.pageController.view.frame = CGRect(x: 0, y: 0 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        pageController.setViewControllers([self.pages[initialPage]], direction: .forward, animated: true, completion: nil)
        self.addChildViewController(pageController)
        self.view.addSubview(pageController.view)
        pageController.didMove(toParentViewController: self)
    }
    
    private func setupSkipButton() {
        let skipButton = UIButton(type: .custom)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.backgroundColor = UIColor.black
        skipButton.setTitle("Skip", for: .normal)
        skipButton.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
        self.view.addSubview(skipButton)
        skipButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30.0).isActive = true
        skipButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10.0).isActive = true
        skipButton.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
    }
}

// MARK: - Action

extension AppIntroPageViewController {
    
    @objc func buttonClicked() {
        print("Button Clicked")
    }
}

// MARK: - UIPageViewController DataSource

extension AppIntroPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.index(of: viewController) {
            
            if viewControllerIndex == 0 {
                return nil
            } else {
                
                return getViewControllerAtIndex(index: viewControllerIndex - 1)
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.index(of: viewController) {
            
            if viewControllerIndex < self.pages.count - 1 {
                return getViewControllerAtIndex(index: viewControllerIndex + 1)
                
            } else {
                return nil
            }
        }
        return nil
    }
 
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.index(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
        }
    }
    
    func getViewControllerAtIndex(index: NSInteger) -> PageContentViewController
    {
        if let pageContentViewController = self.pages[index] as? PageContentViewController {
            pageContentViewController.strTitle = viewModel.tutorialList[index].title
            pageContentViewController.pageIndex = index
            pageContentViewController.strPhotoName = viewModel.tutorialList[index].picture
            return pageContentViewController
        }
        return PageContentViewController()
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return numberOfPages
    }
    
}

// MARK: - UIScrollView Delegate

extension AppIntroPageViewController: UIScrollViewDelegate {
    
    private func setScrollViewDelegate() {
        if let subViews = pageController.view.subviews as? [UIScrollView] {
            for scrollview in subViews {
                scrollview.delegate = self
            }
        }
    }
}
