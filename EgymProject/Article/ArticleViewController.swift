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
    

    // MARK: - Properties
    
    var viewModel: ArticleViewModel!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
}
