import UIKit

class TabViewController1: TabViewControllerBase {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.greenColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setUp() {
        tabBarTitle = "Google"
        tabMainTitle = "Google急上昇ワード"
        tabUrl = "http://checktrend.herokuapp.com/api/trend/google.json"
    }
    
}

