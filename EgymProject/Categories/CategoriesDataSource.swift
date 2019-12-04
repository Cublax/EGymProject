//
//  CategoriesDataSource.swift
//  EgymProject
//
//  Created by Alexandre Quiblier on 04/12/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class CategoriesDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Private
    
    private var items: [String] = []
    
    // MARK: - Public
    
    func update(with items: [String]) {
        self.items = items.sorted { $0 < $1 }
    }
    
    var didSelectItem: ((String) -> Void)?
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.item < items.count else { fatalError() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath) as! CategoriesTableViewCell
        cell.configure(with: items[indexPath.row])
        return cell
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.item < items.count else {
            assertionFailure("Index out of Range")
            return
        }
        
        let index = indexPath.item
        didSelectItem?(items[index])
    }
}
