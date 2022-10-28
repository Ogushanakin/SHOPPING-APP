//
//  SearchController.swift
//  SHOPPING-APP
//
//  Created by AKIN on 26.10.2022.
//


import UIKit

final class SearchController: UITableViewController, UISearchResultsUpdating {
    
    let searchController = UISearchController()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        print(text)
    }
}
