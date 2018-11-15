//
//  AppIntroViewModel.swift
//  AppIntro
//
//  Created by Shantaram Kokate on 11/15/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import Foundation
import UIKit
class AppIntroViewModel {
    
    var tutorialList: [Tutorial] {
        return [
            Tutorial(title: "Home", description: "nique and powerful suite of software to run your entire business, brought to you by a company with the long term vision to transform the way you work.Experience the Operating System for Business.@", picture: #imageLiteral(resourceName: "Home")),
            
            Tutorial(title: "Account", description: "nique and powerful suite of software to run your entire business, brought to you by a company with the long term vision to transform the way you work.Experience the Operating System for Business.@", picture: #imageLiteral(resourceName: "Account")),
            
            Tutorial(title: "Notification", description: "nique and powerful suite of software to run your entire business, brought to you by a company with the long term vision to transform the way you work.Experience the Operating System for Business.@", picture: #imageLiteral(resourceName: "Account"))]
    }
    
    lazy var orderedViewControllers: [PageContentViewController] = {
        return newViewControllers()
    }()
    
    func newViewControllers() -> [PageContentViewController] {
        var list = [PageContentViewController]()
        for (index, _) in tutorialList.enumerated() {
            let storyborad = UIStoryboard(name: "Main", bundle: nil)
            let pageContentViewController = storyborad.instantiateViewController(withIdentifier: "PageContentViewController") as! PageContentViewController
            pageContentViewController.strTitle = tutorialList[index].title
            pageContentViewController.strPhotoName = tutorialList[index].picture
            pageContentViewController.pageIndex = index
            list.append(pageContentViewController)
        }
        return list
    }
    
}
