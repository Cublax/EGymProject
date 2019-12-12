//
//  CategoriesTableViewCell.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 04/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class CategoriesTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var categoryLabel: UILabel!
    
    // MARK: - Configure
    
    func configure(with title: String) {
        self.categoryLabel.text = title
    }
    
    override func prepareForReuse() {
        categoryLabel.text = nil
    }
}
