import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    var tabView1: TabViewController1!
    var tabView2: TabViewController2!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabView1 = TabViewController1()
        tabView2 = TabViewController2()

        //tabView1.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Bookmarks, tag: 1)
        //tabView2.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Bookmarks, tag: 2)
        tabView1.tabBarItem = UITabBarItem(title: "Google", image: UIImage(named: "icon_G.png"), selectedImage: UIImage(named: "icon_G.png"))
        tabView2.tabBarItem = UITabBarItem(title: "Yahoo", image: UIImage(named: "icon_Y.png"), selectedImage: UIImage(named: "icon_Y.png"))
        
        //navbar
        var navigationController1 = UINavigationController(rootViewController: tabView1)
        var navigationController2 = UINavigationController(rootViewController: tabView2)
        self.setViewControllers(
            [navigationController1, navigationController2],
            animated: false
        )

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
