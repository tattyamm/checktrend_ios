import UIKit
import GoogleMobileAds

class WebViewController: UIViewController,UIWebViewDelegate, GADBannerViewDelegate {

    var startUrl:String = ""
    var viewTitle = ""
    let myWebView : UIWebView = UIWebView()
    let ADMOB_ID = "" //設定の必要あり
    let TABBAR_HEIGHT_DEFAULT : CGFloat = 44.0
    
    var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = viewTitle  // webのタイトルにするか？
        self.view.backgroundColor = UIColor.whiteColor()
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        //webview
        myWebView.delegate = self
        //myWebView.frame = self.view.bounds
        var navBarHeight = (self.navigationController?.navigationBar.frame.size.height) ?? TABBAR_HEIGHT_DEFAULT
        myWebView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - navBarHeight)
        self.view.addSubview(myWebView)
        let url: NSURL = NSURL(string: startUrl)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        myWebView.loadRequest(request)
        
        //button
        var settingBtn:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        settingBtn.addTarget(self, action: "onClickNavBarButton", forControlEvents: UIControlEvents.TouchUpInside)
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

        var navBarHeight = (self.navigationController?.navigationBar.frame.size.height) ?? TABBAR_HEIGHT_DEFAULT
        bannerView.frame.origin = CGPointMake(0, self.view.frame.size.height - bannerView.frame.height - navBarHeight)
        bannerView.frame.size = CGSizeMake(self.view.frame.width, bannerView.frame.height)
        bannerView.adUnitID = ADMOB_ID
        bannerView.delegate = self
        bannerView.rootViewController = self
        
        var request:GADRequest = GADRequest()
        bannerView.loadRequest(request)
        
        return bannerView
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            
            //google analytics
            let screenName = reflect(self).summary
            println (screenName)
            var tracker = GAI.sharedInstance().defaultTracker
            tracker.set(kGAIScreenName, value: screenName)
            var builder = GAIDictionaryBuilder.createScreenView()
            tracker.send(builder.build() as [NSObject : AnyObject])
        }
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        println("ページ読み込み完了")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }

    func webViewDidStartLoad(webView: UIWebView) {
        println("ページ読み込み開始")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func onClickNavBarButton() {
        let currentUrl : String = (myWebView.request?.URL!.absoluteString)!
        println("current url : " + currentUrl)
        
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
