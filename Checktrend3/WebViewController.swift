//
//  http://kzy52.com/entry/2015/02/20/000838

import UIKit

class WebViewController: UIViewController,UIWebViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "webview title"
        
        //画面一杯にWebを表示
        let myWebView : UIWebView = UIWebView()
        myWebView.delegate = self
        myWebView.frame = self.view.bounds
        self.view.addSubview(myWebView)
        let url: NSURL = NSURL(string: "http://google.com")!
        let request: NSURLRequest = NSURLRequest(URL: url)
        myWebView.loadRequest(request)
    }
    //ページが読み終わったときに呼ばれる関数
    func webViewDidFinishLoad(webView: UIWebView) {
        println("ページ読み込み完了しました！")
    }
    //ページを読み始めた時に呼ばれる関数
    func webViewDidStartLoad(webView: UIWebView) {
        println("ページ読み込み開始しました！")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
