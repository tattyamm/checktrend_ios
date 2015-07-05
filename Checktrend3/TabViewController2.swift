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
        tabMainTitle = NSLocalizedString("LANG_VIEW2_TITLE", comment: "text")
        tabUrl = NSLocalizedString("LANG_VIEW2_URL", comment: "url")
    }
    
}

