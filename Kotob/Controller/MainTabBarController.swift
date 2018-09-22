//
//  MainTabBarController.swift
//  Kotob
//
//  Created by Mokhtar on 9/21/18.
//  Copyright © 2018 Mokhtar. All rights reserved.
//

import UIKit

class MainTabBarController : UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        

        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().barTintColor = UIColor(r: 243, g: 245, b: 248)
        
        tabBar.tintColor = .nagwaOrange
        
        setupViewControllers()
    }
    
    
    func setupViewControllers() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let homeController = NewHomeController()
        
        viewControllers = [
            
            generateNavigationController(for: homeController , title: "المكتبة", image: UIImage(named: "home")! ),
            generateNavigationController(for: UIViewController(), title: "مكتبتي", image: UIImage(named: "library")!)
        ]
    }
    
    //MARK:- Helper Functions
    
    fileprivate func generateNavigationController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
