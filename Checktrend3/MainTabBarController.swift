//
//  MainTabBarController.swift
//  Checktrend3
//
//  Created by tatsuya endo on 2015/06/20.
//  Copyright (c) 2015年 tattyamm. All rights reserved.
//

import Foundation
import UIKit

//UITabBarControllerを継承
class MainTabBarController: UITabBarController {
    var firstView: FirstViewController!
    var secondView: SecondViewController!
    var tabView1: TabViewController1!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstView = FirstViewController()
        secondView = SecondViewController()
        tabView1 = TabViewController1()
        
        //表示するtabItemを指定（今回はデフォルトのItemを使用）
        firstView.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Featured, tag: 1)
        secondView.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Bookmarks, tag: 2)
        tabView1.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Bookmarks, tag: 3)
        
        // タブで表示するViewControllerを配列に格納します。
        let myTabs = NSArray(objects: firstView!, secondView!, tabView1!)
        
        // 配列をTabにセットします。
        self.setViewControllers(myTabs as [AnyObject], animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
