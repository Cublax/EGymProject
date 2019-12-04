//
//  ArticleViewController.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 29/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    
    // MARK: - Outlets
    
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
                self?.configureImage(with: article.bigPictureUrl)
                self?.titleLabel.text = article.title
                self?.authorLabel.text = article.author
                self?.subTitleLabel.text = article.subTitle
            }
        }
    }
    
    private func configureImage(with url: String) {
        cancellationToken = RequestCancellationToken()
        guard let url = URL(string: url) else { return }
        imageProvider?.setImage(for: url, cancelledBy: cancellationToken) { [weak self] image in
            DispatchQueue.main.async {
                self?.articleImageView.image = image
            }
        }
    }
    
    @IBAction func didPressShowMoreButton(_ sender: Any) {
        viewModel.openWebView()
    }
}
