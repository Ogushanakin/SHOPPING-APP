//
//  CartFooterView.swift
//  SHOPPING-APP
//
//  Created by AKIN on 30.10.2022.
//

import UIKit
import Firebase

protocol CartFooterDelegate: AnyObject {
    func handleLogout()
}

final class CartFooterView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: CartFooterDelegate?
    
    private lazy var checkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CHECKOUT", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(checkout), for: .touchUpInside)
        return button
    }()
    
    lazy var titleContainerView: UIView = {
        let view = UIView()
    
        let stack = UIStackView(arrangedSubviews: [totalLabel, totalCountLabel])
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = 6
        
        view.addSubview(stack)
        stack.centerX(inView: view)
        
        return view
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 26, weight: .light)
        label.numberOfLines = 4
        label.text = "Total:"
        return label
    }()
    
    let totalCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.text = "119.97$"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(titleContainerView)
        titleContainerView.anchor(left: leftAnchor, right: rightAnchor,
                            paddingLeft: 32, paddingRight: 32)
        titleContainerView.centerY(inView: self)
        titleContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        addSubview(checkoutButton)
        checkoutButton.anchor(top: titleContainerView.bottomAnchor,
                              left: leftAnchor, right: rightAnchor,
                              paddingTop: 40, paddingLeft: 32, paddingRight: 32)
        checkoutButton.centerY(inView: self)
        checkoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func checkout() {
        print("checkout")
    }
    
    // MARK: - Helpers
    
}
