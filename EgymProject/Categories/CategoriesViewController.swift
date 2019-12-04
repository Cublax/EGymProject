//
//  CategoriesViewController.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 29/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var viewModel: CategoriesViewModel!
    
    private let dataSource = CategoriesDataSource()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        bind(to: viewModel)
        bind(to: dataSource)
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: CategoriesViewModel) {
        viewModel.visibleCategories = { [weak self] categories in
           DispatchQueue.main.async {
               self?.dataSource.update(with: categories)
               self?.tableView.reloadData()
           }
       }
    }
    
    private func bind(to dataSource: CategoriesDataSource) {
        dataSource.didSelectItem = viewModel.didSelectCategory
    }
}

