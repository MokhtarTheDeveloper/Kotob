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
        
        customizeNavigationBar()
        
        tabBar.tintColor = .nagwaOrange
        
        setupViewControllers()
    }
    
    
    fileprivate func customizeNavigationBar() {
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().barTintColor = UIColor(r: 243, g: 245, b: 248)
    }
    
    
    func setupViewControllers() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let homeController = HomeController()
        
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
