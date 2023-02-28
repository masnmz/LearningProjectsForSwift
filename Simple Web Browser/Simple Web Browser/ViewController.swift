//
//  ViewController.swift
//  Simple Web Browser
//
//  Created by Mehmet Alp Sönmez on 29.12.2022.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView : WKWebView!
    var progressView : UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let back = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                   style: .plain,
                                   target: webView,
                                   action: #selector(webView.goBack))
        let forward = UIBarButtonItem(image: UIImage(systemName: "chevron.forward"),
                                      style: .plain,
                                      target: webView,
                                      action: #selector(webView.goForward))
        
        
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressButton, spacer, back, forward, refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let url = URL(string: "https://" + (websites[0]))!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    

    @objc func openTapped(){
        let alertcontroller = UIAlertController(title: "Open Page...", message: nil, preferredStyle: .actionSheet)
        
        for website in websites {
            alertcontroller.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
       
        
        alertcontroller.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertcontroller.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(alertcontroller, animated: true)
        
        
    }
    func openPage(action : UIAlertAction){
        guard let actionTitle = action.title else {return}
        guard let url = URL(string: "https://" + actionTitle) else {return}
                webView.load(URLRequest(url: url))
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host{
            for website in websites {
                if host.contains(website){
                    decisionHandler(.allow)
                    return
                }
            }
            let alert = UIAlertController(title: title, message: "This website is now allowed to visit", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            alert.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            present(alert, animated: true)
        }
        decisionHandler(.cancel)
        
    }
}

