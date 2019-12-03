//
//  ListingViewController.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 29/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

class ListingViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var viewModel: ListingViewModel!
    
    var imageProvider: ImageProvider!
    
    private lazy var dataSource: ListingDataSource = {
           return ListingDataSource(imageProvider: imageProvider)
       }()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        bind(to: dataSource)
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: ListingViewModel) {
        viewModel.visibleArticles = { [weak self] articles in
           DispatchQueue.main.async {
               self?.dataSource.update(with: articles)
               self?.tableView.reloadData()
           }
       }
    }
    
    private func bind(to dataSource: ListingDataSource) {
        dataSource.didSelectItem = viewModel.didSelectArticle
    }
}

