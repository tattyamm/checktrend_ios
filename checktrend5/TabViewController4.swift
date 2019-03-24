import UIKit

class TabViewController4: TabViewControllerBase {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUp() {
        tabBarTitle = "Amazon"
        tabMainTitle = NSLocalizedString("LANG_VIEW4_TITLE", comment: "text")
        tabUrl = NSLocalizedString("LANG_VIEW4_URL", comment: "url")
    }
}
