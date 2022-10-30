//
//  ProductDetailController.swift
//  SHOPPING-APP
//
//  Created by AKIN on 28.10.2022.
//

import UIKit
import Firebase

private let cellreuseIdentifier = "ProductDetailCell"

protocol ProductControllerDelegate: AnyObject {
    func handleLogout()
}

final class ProductDetailController: UITableViewController {
    
    // MARK: - Properties
    
    weak var delegate: ProductControllerDelegate?
    
    private var product: ProductModel? {
        didSet { headerView.product = product }
    }
    
    private lazy var headerView = ProductHeader(frame: .init(x: 0, y: 0,
                                                             width: view.frame.width,
                                                             height: 480))
    
    private let footerView = ProductFooterView()
    
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
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Service.fetchProduct(withUid: uid) { product in
            self.product = product
            
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        navigationItem.title = "Product Detail"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(closeDetailPage))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.222751677, green: 0.3736387491, blue: 0.3669503331, alpha: 1)
        
        tableView.tableHeaderView = headerView
        headerView.delegate = self
        tableView.register(ProductDetailCell.self, forCellReuseIdentifier: cellreuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = 180
        tableView.backgroundColor = .white
        
        footerView.delegate = self
        footerView.frame = .init(x: 0, y: 0, width: view.frame.width, height: 250)
        tableView.tableFooterView = footerView
    }
}

    // MARK: - UITableViewDataSource

extension ProductDetailController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductViewModel.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellreuseIdentifier, for: indexPath) as! ProductDetailCell
        
        let viewModel = ProductViewModel(rawValue: indexPath.row)
        cell.viewModel = viewModel
        
        cell.selectionStyle = .none
        return cell
    }
}

     // MARK: - UITableViewDelegate

extension ProductDetailController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = ProductViewModel(rawValue: indexPath.row) else { return }
        
        switch viewModel {
        case .description:
            print("DEBUG: Show account info page..")
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}

// MARK: - ProfileHeaderDelegate

extension ProductDetailController: ProductHeaderDelegate {
    func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}

extension ProductDetailController: ProductFooterDelegate {
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
