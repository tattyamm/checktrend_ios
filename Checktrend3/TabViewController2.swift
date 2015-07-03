import UIKit

class TabViewController2: TabViewControllerBase {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        println("tabTitle = " + tabTitle)
        println("tabUrl = " + tabUrl)
        self.view.backgroundColor = UIColor.greenColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setUp() {
        tabTitle = "Yahoo"
        tabUrl = "http://checktrend.herokuapp.com/api/trend/yahoo.json"
    }
    
}

