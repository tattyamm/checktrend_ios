import UIKit
import WebKit
import GoogleMobileAds

class WebViewController: UIViewController, GADBannerViewDelegate {
    
    var startUrl:String = ""
    var viewTitle = ""
    let ADMOB_ID = ""   //適宜設定
    let TABBAR_HEIGHT_DEFAULT : CGFloat = 50.0//44.0
    
    var _webkitview: WKWebView?
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = viewTitle  // webのタイトルにするか？
        self.view.backgroundColor = UIColor.whiteColor()
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        //wkwebview
        let navBarHeight = (self.navigationController?.navigationBar.frame.size.height) ??  TABBAR_HEIGHT_DEFAULT
        let webviewFrame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - navBarHeight)
        self._webkitview = WKWebView(frame: webviewFrame)
        self.view = self._webkitview!
        let url = NSURL(string:startUrl)!
        let req = NSURLRequest(URL:url)
        self._webkitview!.loadRequest(req)
        
        //button
        let settingBtn = UIButton(type: UIButtonType.System)
        settingBtn.addTarget(self, action: #selector(WebViewController.onClickNavBarButton), forControlEvents: UIControlEvents.TouchUpInside)
        settingBtn.frame = CGRectMake(0, 0, 24, 24)
        settingBtn.setImage(UIImage(named: "Share.png"), forState: .Normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingBtn)
        
        //ad admob
        let bannerView:GADBannerView = getAdBannerView()
        self.view.addSubview(bannerView)
    }
    
    private func getAdBannerView() -> GADBannerView {
        var bannerView: GADBannerView = GADBannerView()
        bannerView = GADBannerView(adSize:kGADAdSizeBanner)
        
        //let navBarHeight = (self.navigationController?.navigationBar.frame.size.height) ?? TABBAR_HEIGHT_DEFAULT
        let navBarHeight:CGFloat = 0
        bannerView.frame.origin = CGPointMake(0, self.view.frame.size.height - bannerView.frame.height - navBarHeight)
        bannerView.frame.size = CGSizeMake(self.view.frame.width, bannerView.frame.height)
        bannerView.adUnitID = ADMOB_ID
        bannerView.delegate = self
        bannerView.rootViewController = self
        
        let request:GADRequest = GADRequest()
        bannerView.loadRequest(request)
        
        return bannerView
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if (UIApplication.sharedApplication().delegate as? AppDelegate) != nil {
            
            //google analytics
            let screenName = NSStringFromClass(self.dynamicType)
            print ("screenname" + screenName)
            let tracker = GAI.sharedInstance().defaultTracker
            tracker.set(kGAIScreenName, value: screenName)
            let builder = GAIDictionaryBuilder.createScreenView()
            tracker.send(builder.build() as [NSObject : AnyObject])
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        print("ページ読み込み完了")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        print("ページ読み込み開始")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func onClickNavBarButton() {
        let currentUrl : String = (_webkitview?.URL?.absoluteString)!
        print("current url : " + currentUrl)
        
        trackEvent("button", action: "share", label: currentUrl, value: nil)
        
        let url = NSURL(string: currentUrl)
        if UIApplication.sharedApplication().canOpenURL(url!){
            UIApplication.sharedApplication().openURL(url!)
        }
    }
    
    func trackEvent(category: String, action: String, label: String, value: NSNumber?) {
        let tracker = GAI.sharedInstance().defaultTracker
        let trackDictionary = GAIDictionaryBuilder.createEventWithCategory(category, action: action, label: label, value: value).build()
        tracker.send(trackDictionary as [NSObject : AnyObject])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
