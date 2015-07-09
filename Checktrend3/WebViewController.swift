//
//  http://kzy52.com/entry/2015/02/20/000838

import UIKit
import GoogleMobileAds

class WebViewController: UIViewController,UIWebViewDelegate, GADBannerViewDelegate {

    var startUrl:String = ""
    var viewTitle = ""
    let myWebView : UIWebView = UIWebView()
    
    var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = viewTitle  // webのタイトルにするか？

        //webview
        myWebView.delegate = self
        myWebView.frame = self.view.bounds
        self.view.addSubview(myWebView)
        let url: NSURL = NSURL(string: startUrl)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        myWebView.loadRequest(request)
        
        //button
        var settingBtn:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        settingBtn.addTarget(self, action: "onClickNavBarButton", forControlEvents: UIControlEvents.TouchUpInside)
        settingBtn.frame = CGRectMake(0, 0, 24, 24)
        settingBtn.setImage(UIImage(named: "Info.png"), forState: .Normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingBtn)

        //ad http://www.sirochro.com/note/swift-admob-implementation/
        let bannerView:GADBannerView = getAdBannerView()
        self.view.addSubview(bannerView)
    }
    
    private func getAdBannerView() -> GADBannerView {
        var bannerView: GADBannerView = GADBannerView()
        bannerView = GADBannerView(adSize:kGADAdSizeBanner)
        //TODO tabbar分の高さを引く
        bannerView.frame.origin = CGPointMake(0, self.view.frame.size.height - bannerView.frame.height - 50)
        bannerView.frame.size = CGSizeMake(self.view.frame.width, bannerView.frame.height)
        bannerView.adUnitID = "ca-app-pub-5040713306305537/8685162711"
        bannerView.delegate = self
        bannerView.rootViewController = self
        
        var request:GADRequest = GADRequest()
        bannerView.loadRequest(request)
        
        return bannerView
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        println("ページ読み込み完了")
    }

    func webViewDidStartLoad(webView: UIWebView) {
        println("ページ読み込み開始")
    }
    
    func onClickNavBarButton() {
        let currentUrl : String = (myWebView.request?.URL!.absoluteString)!
        println("current url : " + currentUrl)
        
        let url = NSURL(string: currentUrl)
        if UIApplication.sharedApplication().canOpenURL(url!){
            UIApplication.sharedApplication().openURL(url!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
