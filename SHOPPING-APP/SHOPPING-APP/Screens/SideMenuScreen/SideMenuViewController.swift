//
//  SideMenuViewController.swift
//  SHOPPING-APP
//
//  Created by AKIN on 28.10.2022.
//

import UIKit
import Firebase

private let reuseIdentifier = "SideMenuCell"

protocol SideMenuControllerDelegate: AnyObject {
    func handleLogout()
}

final class SideMenuViewController: UITableViewController {
    
    // MARK: - Properties
    
    weak var delegate: SideMenuControllerDelegate?
    
    private var user: User? {
        didSet { headerView.user = user }
    }
    
    private lazy var headerView = SideMenuHeader(frame: .init(x: 0, y: 0,
                                                             width: view.frame.width,
                                                             height: 200))
    
    private let footerView = SideMenuFooterView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    // MARK: - Selectors
    
    // MARK: - API
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Service.fetchUser(withUid: uid) { user in
            self.user = user
            
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        tableView.tableHeaderView = headerView
        headerView.delegate = self
        tableView.register(SideMenuCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = 64
        tableView.backgroundColor = .white
        
        footerView.delegate = self
        footerView.frame = .init(x: 0, y: 0, width: view.frame.width, height: 400)
        tableView.tableFooterView = footerView
    }
}

    // MARK: - UITableViewDataSource

extension SideMenuViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SideMenuViewModel.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SideMenuCell
        
        let viewModel = SideMenuViewModel(rawValue: indexPath.row)
        cell.viewModel = viewModel
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

     // MARK: - UITableViewDelegate

extension SideMenuViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = ProfileViewModel(rawValue: indexPath.row) else { return }
        
        switch viewModel {
        case .accountInfo:
            print("DEBUG: Show account info page..")
        case .favorites:
            print("DEBUG: Show favorites list page...")
        case .settings:
            print("DEBUG: Show settings page...")
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}

// MARK: - ProfileHeaderDelegate

extension SideMenuViewController: SideMenuHeaderDelegate {
    func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}

extension SideMenuViewController: SideMenuFooterDelegate {
    func handleLogout() {
        let alert = UIAlertController(title: nil, message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            self.dismiss(animated: true) {
                self.delegate?.handleLogout()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
        
        let controller = LoginViewController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
        
    }
}
