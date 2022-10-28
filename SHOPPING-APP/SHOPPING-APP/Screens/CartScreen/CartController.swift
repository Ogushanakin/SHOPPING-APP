//
//  CartController.swift
//  SHOPPING-APP
//
//  Created by AKIN on 28.10.2022.
//

import UIKit

final class CartController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureNavigationBarButtons()
    }
    
    func configureNavigationBarButtons() {
        navigationItem.title = "CART"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(closeCart))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
    }
    
    @objc func closeCart() {
        dismiss(animated: true, completion: nil)
    }
}
