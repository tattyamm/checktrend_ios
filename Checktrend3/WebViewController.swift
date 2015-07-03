//
//  http://kzy52.com/entry/2015/02/20/000838

import UIKit

class WebViewController: UIViewController,UIWebViewDelegate {
    
    var startUrl:String = ""
    var viewTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = viewTitle  // webのタイトルにするか？
        
        let myWebView : UIWebView = UIWebView()
        myWebView.delegate = self
        myWebView.frame = self.view.bounds
        self.view.addSubview(myWebView)
        let url: NSURL = NSURL(string: startUrl)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        myWebView.loadRequest(request)
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        println("ページ読み込み完了")
    }

    func webViewDidStartLoad(webView: UIWebView) {
        println("ページ読み込み開始")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
