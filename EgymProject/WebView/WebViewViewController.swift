//
//  WebViewViewController.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 05/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit
import WebKit
import CoreData

class WebViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var webView: WKWebView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    var viewModel: WebViewViewModel!
    
    var address: String = "" {
        didSet {
            loadWebView(url: address)
        }
    }
    
    var imageProvider: ImageProvider!
    
    private var cancellationToken: RequestCancellationToken!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: WebViewViewModel) {
        viewModel.address = { [weak self] address in
            self?.address = address
        }
        
        viewModel.isFavorite = { [weak self] state in
            self?.setFavorite(favorite: state)
        }
    }
    
    private func loadWebView(url: String) {
        guard let url = URL(string: address) else {return}
        webView.load(URLRequest(url: url))
        webView.navigationDelegate = self
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    private func setFavorite(favorite: Bool) {
        guard let selected = UIImage(systemName: "bookmark.fill") else { return }
        guard let unselected = UIImage(systemName: "bookmark") else { return }
        var bookmark: UIImage
        
        switch favorite {
        case true:
            bookmark = selected
        case false:
            bookmark = unselected
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: bookmark, style: .done, target: self, action: #selector(didPressFavorite))
    }
    
    @objc private func didPressFavorite() {
        viewModel.clickedOnFavorite()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

