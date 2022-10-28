//
//  SideMenuHeader.swift
//  SHOPPING-APP
//
//  Created by AKIN on 28.10.2022.
//

import UIKit

protocol SideMenuHeaderDelegate: AnyObject {
    func dismissController()
}

final class SideMenuHeader: UIView {
    
    // MARK: - Properties
    
    var user: User? {
        didSet { populateUserData() }
    }
    
    weak var delegate: SideMenuHeaderDelegate?
    
    private let profileImageView: UIImageView = {
         let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "profile")
        iv.layer.borderColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
        iv.layer.borderWidth = 4.0
        return iv
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
        label.textAlignment = .center
        label.text = "Oğuzhan Akın"
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.text = "@ogushanakin"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleDismissal() {
        delegate?.dismissController()
    }
    
    
    // MARK: - Helpers
    
    func populateUserData() {
        guard let user = user else { return }
        
        fullnameLabel.text = user.fullname
        usernameLabel.text = "@" + user.username

    }
    
    func configureUI() {
        backgroundColor = .white
        
        profileImageView.setDimensions(height: 100, width: 100)
        profileImageView.layer.cornerRadius = 50
        
        addSubview(profileImageView)
        profileImageView.centerX(inView: self)
        profileImageView.anchor(top: topAnchor, paddingTop: 80)
        
        let stack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.centerX(inView: self)
        stack.anchor(top: profileImageView.bottomAnchor, paddingTop: 8)
        
    }

}

