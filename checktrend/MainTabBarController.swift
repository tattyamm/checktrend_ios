import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    var tabView1: TabViewController1!
    var tabView2: TabViewController2!
    var tabView3: TabViewController3!
    var tabView4: TabViewController4!

    override func viewDidLoad() {
        super.viewDidLoad()
        tabView1 = TabViewController1()
        tabView2 = TabViewController2()
        tabView3 = TabViewController3()
        tabView4 = TabViewController4()

        tabView1.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Bookmarks, tag: 1)
        tabView2.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Bookmarks, tag: 2)
        tabView1.tabBarItem = UITabBarItem(title: "Google",  image: UIImage(named: "icon_G.png"), selectedImage: UIImage(named: "icon_G.png"))
        tabView2.tabBarItem = UITabBarItem(title: "Yahoo",   image: UIImage(named: "icon_Y.png"), selectedImage: UIImage(named: "icon_Y.png"))
        tabView3.tabBarItem = UITabBarItem(title: "twitter", image: UIImage(named: "icon_t.png"), selectedImage: UIImage(named: "icon_t.png"))
        tabView4.tabBarItem = UITabBarItem(title: "Amazon",  image: UIImage(named: "icon_A.png"), selectedImage: UIImage(named: "icon_A.png"))

        //navbar
        let navigationController1 = UINavigationController(rootViewController: tabView1)
        let navigationController2 = UINavigationController(rootViewController: tabView2)
        let navigationController3 = UINavigationController(rootViewController: tabView3)
        let navigationController4 = UINavigationController(rootViewController: tabView4)
        self.setViewControllers(
            [navigationController1, navigationController2, navigationController3, navigationController4],
            animated: false
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
