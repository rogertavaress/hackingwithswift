//
//  ViewController.swift
//  project-4
//
//  Created by Rogério Tavares on 30/12/21.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var tableviewDelegate: TableViewControllerDelegate!
    var webView: WKWebView!
    var progressView: UIProgressView!
    var initWebSite: WebSiteModel!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        navigationItem.largeTitleDisplayMode = .never
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let forward = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webView, action: #selector(webView.goForward))
        let goBack = UIBarButtonItem(barButtonSystemItem: .rewind, target: webView, action: #selector(webView.goBack))
        
        toolbarItems = [progressButton, spacer, goBack, forward, refresh]
        navigationController?.isToolbarHidden = false
        
        let url = initWebSite.url
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }

    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        
        for website in tableviewDelegate.websites {
            ac.addAction(UIAlertAction(title: website.link, style: .default, handler: openPage))
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(alert: UIAlertAction) {
        guard let webSiteItem = tableviewDelegate.websites.first(where: { item in
            return item.link == alert.title
        }) else { return }
        
        webView.load(URLRequest(url: webSiteItem.url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in tableviewDelegate.websites {
                if host.contains(website.link) {
                    decisionHandler(.allow)
                    return
                }
            }
        } else {
            decisionHandler(.cancel)
            return
        }
        
        let alertController = UIAlertController(title: "Error", message: "Wrong page", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Go back", style: .cancel, handler: { _ in
            decisionHandler(.cancel)
        }))
        
        present(alertController, animated: true)
    }
}

