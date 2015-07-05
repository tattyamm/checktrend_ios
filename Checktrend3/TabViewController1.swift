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
        tabMainTitle = NSLocalizedString("LANG_VIEW1_TITLE", comment: "text")
        tabUrl = NSLocalizedString("LANG_VIEW1_URL", comment: "url")
    }
    
}

