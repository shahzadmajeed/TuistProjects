
import UIKit
import WebKit
import Core
import SnapKit

public class WebViewController: UIViewController {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var webView: WKWebView!
    
    public init() {
        super.init(nibName: "WebViewController", bundle: Bundle.module)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func load(_ url: URL) {
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}

// WebViewControllerPreviews.swift
#if DEBUG
import SwiftUI
struct WebViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        let webViewController = WebViewController()
        webViewController.load(URL(string: "http://www.apple.com/developer")!)
        return webViewController.preview
    }
}
#endif
