import UIKit

class TabViewController1: TabViewControllerBase {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUp() {
        tabBarTitle = "Google"
        tabMainTitle = NSLocalizedString("LANG_VIEW1_TITLE", comment: "text")
        tabUrl = NSLocalizedString("LANG_VIEW1_URL", comment: "url")
    }

}
