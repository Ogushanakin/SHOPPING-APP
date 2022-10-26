//
//  ProfileController.swift
//  SHOPPING-APP
//
//  Created by AKIN on 26.10.2022.
//

import UIKit

final class ProfileController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureNavigation()
    }
    
    private func configureNavigation() {
        configureNavigationBar(withTitle: "PROFILE", prefersLargeTitles: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .done, target: self, action: #selector(handleShowChart))
        navigationItem.rightBarButtonItem?.tintColor = .label
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "sidebar.left"), style: .done, target: self, action: #selector(handleShowMenu))
        navigationItem.leftBarButtonItem?.tintColor = .label
    }
    
    @objc func handleShowChart() {
        
    }
    
    @objc func handleShowMenu() {
        
    }
}
