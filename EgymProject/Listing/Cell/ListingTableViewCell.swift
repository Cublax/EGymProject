//
//  ListingTableViewCell.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 02/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class ListingTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleNameLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    
    // MARK: - Private properties
    
    private var article: VisibleArticle!
    
    private var imageProvider: ImageProvider?
    
    private var cancellationToken: RequestCancellationToken!
    
    // MARK: - COnfigure
    
    func configure(with article: VisibleArticle, imageProvider: ImageProvider?) {
        self.article = article
        self.imageProvider = imageProvider
        configureCell()
    }
    
    func configureCell() {
        self.articleNameLabel.text = article.title
        self.authorNameLabel.text = article.author
        cancellationToken = RequestCancellationToken()
        if let stringUrl = article.smallPictureUrl, let url = URL(string: stringUrl) {
            imageProvider?.setImage(for: url, cancelledBy: cancellationToken) { [weak self] image in
                DispatchQueue.main.async {
                    self?.articleImageView.image = image
                }
            }
        } else {
//            self?.articleImageView.image = UIi
        }
    }
    
    override func prepareForReuse() {
        cancellationToken = nil
        articleImageView.image = nil
        articleNameLabel.text = nil
        authorNameLabel.text = nil
    }
}
