//
//  TabMainViewController.swift
//  NetfilxClone
//
//  Created by 이송은 on 2023/03/14.
//

import UIKit

class TabMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        mainVC.tabBarItem.title = "Home"
        mainVC.tabBarItem.image = UIImage(systemName: "house")
        let subVC = UIStoryboard(name: "Sub", bundle: nil).instantiateViewController(withIdentifier: "SubViewController") as! SubViewController
        subVC.tabBarItem.title = "New & Hot"
        subVC.tabBarItem.image = UIImage(systemName: "play.rectangle.on.rectangle")
        */
        //self.viewControllers = [mainVC, subVC]
        
        setTabbar()
        setNavi()

    }
    
    func setTabbar(){
        let tabbarAppearance = UITabBarAppearance()
        tabbarAppearance.backgroundColor = .black
//        tabbarAppearance.backgroundEffect = UIBlurEffect(style: .dark) 블러 처리
        let tabbarItemAppearance = UITabBarItemAppearance()
        tabbarItemAppearance.normal.iconColor = .gray
        tabbarItemAppearance.selected.iconColor = .white
        tabbarItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        tabbarItemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        tabbarAppearance.inlineLayoutAppearance = tabbarItemAppearance
        tabbarAppearance.stackedLayoutAppearance = tabbarItemAppearance
        tabbarAppearance.compactInlineLayoutAppearance = tabbarItemAppearance
        
        self.tabBar.standardAppearance = tabbarAppearance
        self.tabBar.scrollEdgeAppearance = tabbarAppearance
    }
    
    func setNavi(){
        let MainNaviVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainNaviViewController") as! MainNaviViewController
        MainNaviVC.tabBarItem.title = "Home"
        MainNaviVC.tabBarItem.image = UIImage(systemName: "house")
        let SubNaviVC = UIStoryboard(name: "Sub", bundle: nil).instantiateViewController(withIdentifier: "SubNaviViewController") as! SubNaviViewController
        SubNaviVC.tabBarItem.title = "New & Hot"
        SubNaviVC.tabBarItem.image = UIImage(systemName: "play.rectangle.on.rectangle")
 
        self.viewControllers = [MainNaviVC, SubNaviVC]
    }
}
