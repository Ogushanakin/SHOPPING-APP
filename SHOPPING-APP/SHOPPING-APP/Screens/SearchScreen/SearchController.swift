//
//  SearchController.swift
//  SHOPPING-APP
//
//  Created by AKIN on 26.10.2022.
//


import UIKit

private let reuseIdentifier = "SearchScreenCell"

final class SearchController: UITableViewController {
    
    // MARK: - Properties
    
    private var products = [ProductModel]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var filtredeProduct = [ProductModel]()
    
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        fetchProducts()
        configureSearchController()
    }
    
    // MARK: - Helpers
    
    func configureTableView() {
        tableView.register(SearchScreenCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.rowHeight = 150
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search Product"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
    
    // MARK: - API
    
    func fetchProducts() {
        ProductService.fetchProducts { products in
            self.products = products
            self.tableView.reloadData()
        }
    }
}

    // MARK: - UITableViewDataSource

extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filtredeProduct.count : products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchScreenCell
        
        let product = inSearchMode ? filtredeProduct[indexPath.row] : products[indexPath.row]
        cell.viewModel = ProductViewModel(product: product)
        
        return cell
    }
}

    // MARK: - UITableViewDelegate

extension SearchController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ProductDetailViewController()
        controller.viewModel = ProductViewModel(product: products[indexPath.row])
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .popover
        self.present(nav, animated: true, completion: nil)
    }
}

    // MARK: - UISearchResultUpdating

extension SearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        
        filtredeProduct = products.filter({
            $0.title.lowercased().contains(searchText) ||
                $0.description.lowercased().contains(searchText)
        })
        
        self.tableView.reloadData()
    }
}
