//
//  ArticleViewController.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 29/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit
import CoreData

class ArticleViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var navigationBar: UINavigationItem!
    
    @IBOutlet private weak var articleImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    
    @IBOutlet private weak var seeMoreButton: UIButton!
    
    // MARK: - Properties
    
    var viewModel: ArticleViewModel!
    
    var imageProvider: ImageProvider!
    
    private var cancellationToken: RequestCancellationToken!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: ArticleViewModel) {
        viewModel.visibleArticle = { [weak self] article in
            DispatchQueue.main.async {
                self?.configureImage(with: article.bigPictureUrl ?? "")
                self?.navigationBar.title = article.category
                self?.titleLabel.text = article.title
                self?.authorLabel.text = article.author
                self?.subTitleLabel.text = article.subTitle
            }
        }
        
        viewModel.isFavorite = { [weak self] state in
            self?.setFavorite(favorite: state)
        }
    }
    
    private func setFavorite(favorite: Bool) {
        let selected = "★"
        let unselected = "☆"
        var bookmark: String
        
        switch favorite {
        case true:
            bookmark = selected
        case false:
            bookmark = unselected
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: bookmark, style: .done, target: self, action: #selector(didPressFavorite))
       // self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: bookmark, style: .done, target: self, action: #selector(didPressFavorite))
    }
    
    private func configureImage(with stringUrl: String) {
        cancellationToken = RequestCancellationToken()
        if stringUrl != "" {
            guard let url = URL(string: stringUrl) else { return }
            imageProvider?.setImage(for: url, cancelledBy: cancellationToken) { [weak self] image in
                DispatchQueue.main.async {
                    self?.articleImageView.image = image
                }}} else {
            self.articleImageView.image = UIImage(named: "default large image")
        }}
    
    @objc private func didPressFavorite() {
        viewModel.clickedOnFavorite()
    }
    
    @IBAction func didPressShowMoreButton(_ sender: Any) {
        viewModel.openWebView()
    }
}
