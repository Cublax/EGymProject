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
        
    }
    
    override func prepareForReuse() {
        cancellationToken = nil
        articleImageView = nil
        articleNameLabel = nil
        authorNameLabel = nil
    }
    
}
