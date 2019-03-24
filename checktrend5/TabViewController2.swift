import UIKit

class TabViewController2: TabViewControllerBase {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUp() {
        tabBarTitle = "Youtube"
        tabMainTitle = NSLocalizedString("LANG_VIEW2_TITLE", comment: "text")
        tabUrl = NSLocalizedString("LANG_VIEW2_URL", comment: "url")
    }
}
