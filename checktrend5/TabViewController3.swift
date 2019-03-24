import UIKit

class TabViewController3: TabViewControllerBase {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUp() {
        tabBarTitle = "Twitter"
        tabMainTitle = NSLocalizedString("LANG_VIEW3_TITLE", comment: "text")
        tabUrl = NSLocalizedString("LANG_VIEW3_URL", comment: "url")
    }
}
