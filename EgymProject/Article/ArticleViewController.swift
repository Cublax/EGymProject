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
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var seeMoreButton: UIButton!
    
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
    
    private func configureImage(with stringUrl: String) {
        cancellationToken = RequestCancellationToken()
        guard let url = URL(string: stringUrl) else { return }
        imageProvider?.setImage(for: url, cancelledBy: cancellationToken) { [weak self] image in
            DispatchQueue.main.async {
                self?.articleImageView.image = image
            }
        }
    }
    
    @objc private func didPressFavorite() {
        viewModel.clickedOnFavorite()
    }
    
    @IBAction func didPressShowMoreButton(_ sender: Any) {
        viewModel.openWebView()
    }
}
