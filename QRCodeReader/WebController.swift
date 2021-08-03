//
//  WebController.swift
//  QRCodeReader
//
//  Created by Kunasilan on 29/10/20.
//  Copyright © 2020 Kunasilan. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import SwiftSoup

enum HTMLError: Error {
    case badInnerHTML
}

struct WebsiteResponse {
    
    var location: String = ""
    
    init(_ innerHTML: Any?) throws {
        guard let htmlString = innerHTML as? String else { throw HTMLError.badInnerHTML }
        let doc = try SwiftSoup.parse(htmlString)
        self.location = try doc.getElementById("location-text")?.text() as? String ?? "cant find location"
        
//        print(location)
    }
}

class WebController: UIViewController {
    
    public var completionHandler: ((String?) -> Void)?
    
    private let webView: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }()
    
    var url: URL!
    var pageLocation: String!
    
    override func viewDidLoad() {
        showWeb()
        configureButtons()
        super.viewDidLoad()
    }
    
    func showWeb() {
        webView.frame = view.bounds
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
        view.addSubview(webView)
        
//        getLocationName()
    }
    
    private func configureButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefresh))
    }

    @objc private func didTapDone() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func didTapRefresh() {
        webView.load(URLRequest(url:url))
    }
}

extension WebController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        parseHTML()
    }
    
    func parseHTML() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML") { (innerHTML, error) in
    //        webView.evaluateJavaScript("document.body.innerHTML") { (innerHTML, error) in
//                print(innerHTML)
                guard let html = innerHTML, error == nil else{
                    return
                }
                do {
                    let webResponse = try WebsiteResponse(html)
                    self.pageLocation = webResponse.location
                    self.completionHandler?(self.pageLocation)
                    print(webResponse.location)
                    print("Got response")
                    
                } catch {}
            }

        }
//        webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML") { (innerHTML, error) in
////        webView.evaluateJavaScript("document.body.innerHTML") { (innerHTML, error) in
//            print(innerHTML)
//            guard let html = innerHTML, error == nil else{
//                return
//            }
//            do {
//                let webResponse = try WebsiteResponse(html)
//                self.pageLocation = webResponse.location
//
//                print(webResponse.location)
//                print("Got response")
//
//            } catch {}
//        }
    }
}
