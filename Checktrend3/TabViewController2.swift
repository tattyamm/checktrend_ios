import UIKit

class TabViewController2: TabViewControllerBase {
    
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
        tabBarTitle = "Yahoo"
        tabMainTitle = "Yahoo急上昇"
        tabUrl = "http://checktrend.herokuapp.com/api/trend/yahoo.json"
    }
    
}

