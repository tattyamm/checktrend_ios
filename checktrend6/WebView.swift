//
//  WebView.swift
//  checktrend6
//
//  Created by Tatsuya Endou on 2022/10/02.
//

//https://www.hfoasi8fje3.work/entry/2020/12/29/%E3%80%90SwiftUI%E3%80%91WKWebView%E3%82%92%E8%A1%A8%E7%A4%BA%E3%81%99%E3%82%8B
//https://www.hfoasi8fje3.work/entry/2021/04/22/%E3%80%90SwiftUI%E3%80%91WKWebView%E5%86%85%E3%81%AE%E3%83%9A%E3%83%BC%E3%82%B8%E3%81%AE%E8%AA%AD%E3%81%BF%E8%BE%BC%E3%81%BF%E7%8A%B6%E6%B3%81%E3%82%92UIProgressView%E3%81%A7%E8%A1%A8%E7%A4%BA%E3%81%99
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var webView = WKWebView()
    var progressView = UIProgressView()
    var urlString: String
    
    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        // "target="_blank""が設定されたリンクも開けるようにする
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            return nil
        }
        
        // WebViewの読み込み状況を監視する
        func addProgressObserver() {
            parent.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        }
        
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            // progressViewのアニメーション処理
            if keyPath == "estimatedProgress" {
                parent.progressView.alpha = 1.0
                parent.progressView.setProgress(Float(parent.webView.estimatedProgress), animated: true)
                
                if parent.webView.estimatedProgress >= 1.0 {
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseOut], animations: { [weak self] in
                        self?.parent.progressView.alpha = 0.0
                    }, completion: { (finished: Bool) in
                        self.parent.progressView.setProgress(0.0, animated: false)
                    })
                }
            }
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView.addSubview(progressView)
        
        // UIProgressViewのレイアウト設定
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.widthAnchor.constraint(equalTo: webView.widthAnchor, multiplier: 1.0).isActive = true
        progressView.topAnchor.constraint(equalTo: webView.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        progressView.leadingAnchor.constraint(equalTo: webView.leadingAnchor, constant: 0).isActive = true
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        context.coordinator.addProgressObserver()

        // makeCoordinatorで生成したCoordinatorクラスのインスタンスを指定
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        
        // スワイプで画面遷移できるようにする
        webView.allowsBackForwardNavigationGestures = true
        
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
