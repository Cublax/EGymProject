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
    

    // MARK: - Properties
    
    var viewModel: CategoriesViewModel!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
}

