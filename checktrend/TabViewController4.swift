import UIKit

class TabViewController4: TabViewControllerBase {
    
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
        tabBarTitle = "Amazon"
        tabMainTitle = NSLocalizedString("LANG_VIEW4_TITLE", comment: "text")
        tabUrl = NSLocalizedString("LANG_VIEW4_URL", comment: "url")
    }
    
}

