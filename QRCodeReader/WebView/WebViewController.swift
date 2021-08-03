//
//  WebViewController.swift
//  QRCodeReader
//
//  Created by Kunasilan on 19/10/20.
//  Copyright © 2020 Kunasilan. All rights reserved.
//

//import UIKit
//import WebKit
//import SwiftSoup
//
//enum HTMLError: Error {
//    case badInnerHTML
//}
//
//struct WebsiteResponse {
//
//    var location: String = ""
//
//    init(_ innerHTML: Any?) throws {
//        guard let htmlString = innerHTML as? String else { throw HTMLError.badInnerHTML }
//        let doc = try SwiftSoup.parse(htmlString)
//        self.location = try doc.getElementById("location-text")?.text() as? String ?? "cant find location"
//
////        print(location)
//    }
//
//}
//
//class WebViewController: UIViewController, WKNavigationDelegate {
//
//    private let webView: WKWebView = {
//        let preferences = WKWebpagePreferences()
//        preferences.allowsContentJavaScript = true
//        let configuration = WKWebViewConfiguration()
//        configuration.defaultWebpagePreferences = preferences
//        let webView = WKWebView(frame: .zero, configuration: configuration)
//        return webView
//    }()
//
//    private let url: URL
//    var pageLocation: String!
//
//    init(url: URL, title: String) {
//        self.url = url
//        super.init(nibName: nil, bundle: nil)
//        self.title = title
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(webView)
//        webView.load(URLRequest(url: url))
//        configureButtons()
////        parseHTML()
//        // Do any additional setup after loading the view.
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        webView.frame = view.bounds
//    }
//
//    private func configureButtons() {
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefresh))
//    }
//
//    @objc private func didTapDone() {
////        let vc = storyboard?.instantiateViewController(identifier: "mainPage") as! QRCodeViewController
////        vc.modalPresentationStyle = .fullScreen
////        present(vc, animated: true)
//        dismiss(animated: true, completion: nil)
//    }
//
//    @objc private func didTapRefresh() {
//        webView.load(URLRequest(url:url))
//    }
//
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        parseHTML()
//    }
//    func parseHTML() {
//        webView.evaluateJavaScript("document.body.innerHTML") { (innerHTML, error) in
//            print(innerHTML)
//            guard let html = innerHTML, error == nil else{
//                return
//            }
//            print(html)



//            do {
//                let webResponse = try WebsiteResponse(html)
//                print("The location is \(webResponse.location)")
//                print("Got response")
//
//            } catch {}

//        }
//    }
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//class WebViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}

//extension WebViewController: WKNavigationDelegate {
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        parseHTML()
//    }
//
//    func parseHTML() {
//        webView.evaluateJavaScript("document.body.innerHTML") { (innerHTML, error) in
//            guard let html = innerHTML, error == nil else{
//                return
//            }
//            do {
//                let webResponse = try WebsiteResponse(html)
//                print("The location is \(webResponse.location)")
//                print("Got response")
//
//            } catch {}
//
//        }
//    }
//}
