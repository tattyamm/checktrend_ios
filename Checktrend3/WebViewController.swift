//
//  http://kzy52.com/entry/2015/02/20/000838

import UIKit

class WebViewController: UIViewController,UIWebViewDelegate {

    var startUrl:String = ""
    var viewTitle = ""
    let myWebView : UIWebView = UIWebView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = viewTitle  // webのタイトルにするか？

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
