//
//  ViewController.swift
//  ThoreTestApp
//
//  Created by Shahzad Majeed on 5/6/22.
//

import UIKit
import WebBrowserKit
import ProgressWebViewController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }

    @IBAction func launchWebview() {
        //push(ProgressWebViewController())
        push(WebViewController())
    }
    
    func push(_ browser: WebPageLoader) {
        navigationController?.pushViewController(browser,
                                                 animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            browser.load(URL(string: "https://tuist.io")!)
        }
    }
}

protocol WebPageLoader: UIViewController {
    func load(_ url: URL)
}
extension WebViewController: WebPageLoader {}
extension ProgressWebViewController: WebPageLoader{}

