import UIKit

class MainTabBarController: UITabBarController {
    var tabView1: TabViewController1!
    var tabView2: TabViewController2!
    var tabView3: TabViewController3!
    var tabView4: TabViewController4!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tabView1 = TabViewController1()
        tabView2 = TabViewController2()
        tabView3 = TabViewController3()
        tabView4 = TabViewController4()
        tabView1.tabBarItem = UITabBarItem(title: "Google",  image: UIImage(named: "icon_G.png"), selectedImage: UIImage(named: "icon_G.png"))
        tabView2.tabBarItem = UITabBarItem(title: "Youtube",   image: UIImage(named: "icon_Y.png"), selectedImage: UIImage(named: "icon_Y.png"))
        tabView3.tabBarItem = UITabBarItem(title: "twitter",   image: UIImage(named: "icon_t.png"), selectedImage: UIImage(named: "icon_t.png"))
        tabView4.tabBarItem = UITabBarItem(title: "Amazon",   image: UIImage(named: "icon_A.png"), selectedImage: UIImage(named: "icon_A.png"))
        //        let myTabs = NSArray(objects: tabView1!, tabView2!, tabView3!, tabView4!)
        //        self.setViewControllers(myTabs as? [UIViewController], animated: false)

        //navbar
        let navigationController1 = UINavigationController(rootViewController: tabView1)
        let navigationController2 = UINavigationController(rootViewController: tabView2)
        let navigationController3 = UINavigationController(rootViewController: tabView3)
        let navigationController4 = UINavigationController(rootViewController: tabView4)
        let myNavigationTabs = NSArray(objects: navigationController1, navigationController2, navigationController3, navigationController4)
        self.setViewControllers(myNavigationTabs as? [UIViewController], animated: false)

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
