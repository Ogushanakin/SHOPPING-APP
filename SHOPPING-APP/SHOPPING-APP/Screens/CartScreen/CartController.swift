//
//  CartController.swift
//  SHOPPING-APP
//
//  Created by AKIN on 28.10.2022.
//

import UIKit
import Firebase

private let cellreuseIdentifier = "CartTableViewCell"

protocol CartControllerDelegate: AnyObject {
    func handleLogout()
}

final class CartController: UITableViewController {
    
    // MARK: - Properties
    
    weak var delegate: CartControllerDelegate?
    private let footerView = CartFooterView()
    
    private var cart = [ProductModel]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchProduct()
    }
    
    // MARK: - Selectors
    
    @objc func closeDetailPage(){
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - API
    
    func fetchProduct() {
        ProductService.fetchCart { products in
            self.cart = products
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        navigationItem.title = "Cart"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(closeDetailPage))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.222751677, green: 0.3736387491, blue: 0.3669503331, alpha: 1)
        
        
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: cellreuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = 150
        tableView.backgroundColor = .white
        
        footerView.delegate = self
        footerView.frame = .init(x: 0, y: 0, width: view.frame.width, height: 250)
        tableView.tableFooterView = footerView
    }
}

    // MARK: - UITableViewDataSource

extension CartController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellreuseIdentifier, for: indexPath) as! CartTableViewCell
        
        cell.viewModel = ProductViewModel(product: cart[indexPath.row])
        
        cell.selectionStyle = .none
        return cell
    }
}

     // MARK: - UITableViewDelegate

extension CartController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}

// MARK: - ProfileHeaderDelegate

extension CartController: CartFooterDelegate {
    func handleLogout() {
        let alert = UIAlertController(title: nil, message: "Are you sure you want add to Cart?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Add Cart", style: .destructive, handler: { _ in
            self.dismiss(animated: true) {
                self.delegate?.handleLogout()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}

