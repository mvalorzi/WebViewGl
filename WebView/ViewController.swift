//
//  ViewController.swift
//  WebView
//
//  Created by Martin Valorzi on 10/12/2021.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    private var webView: WKWebView!
    private var urlString = "https://cdn-webgl.fluidconfigure.com/webgl-viewer/examples/demos/model-loading.html"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let webViewPrefs = WKWebpagePreferences()
        webViewPrefs.allowsContentJavaScript = true
        let webViewConfiguration = WKWebViewConfiguration()
        webViewConfiguration.defaultWebpagePreferences = webViewPrefs
        webView = WKWebView(frame: view.frame, configuration: webViewConfiguration)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView)
        load(url: urlString)
    }
    private func load(url: String){
        webView.load(URLRequest(url:URL(string: url)!))
    }
    func webViewHandler(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        let exceptions = SecTrustCopyExceptions(serverTrust)
        SecTrustSetExceptions(serverTrust, exceptions)
        completionHandler(.useCredential, URLCredential(trust: serverTrust));
    }
}

