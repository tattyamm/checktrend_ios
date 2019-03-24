import UIKit
import WebKit

// https://developer.apple.com/documentation/webkit/wkwebview
class WebViewController: UIViewController , WKUIDelegate, WKNavigationDelegate{

    var webView: WKWebView!
    var startUrl:String = ""
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:startUrl)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // ネットワークインジケータを表示?
        print("start loading")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // ネットワークインジケータを非表示?
        print("finish loading")
        UIApplication.shared.isNetworkActivityIndicatorVisible = false;
    }


}
