//
//  ProductFooterView.swift
//  SHOPPING-APP
//
//  Created by AKIN on 30.10.2022.
//

import UIKit
import Firebase

protocol ProductFooterDelegate: AnyObject {
    func handleLogout()
}

final class ProductFooterView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: ProductFooterDelegate?
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(addCart), for: .touchUpInside)
        return button
    }()
    
    lazy var stepperContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
    
        let stack = UIStackView(arrangedSubviews: [stepperLabel, stepper])
        stack.axis = .vertical
        stack.spacing = 4
        
        view.addSubview(stack)
        stack.centerX(inView: view)
        
        return view
    }()
    
    private lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.tintColor = #colorLiteral(red: 0.222751677, green: 0.3736387491, blue: 0.3669503331, alpha: 1)
        return stepper
    }()
    
    private var stepperLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = #colorLiteral(red: 0.222751677, green: 0.3736387491, blue: 0.3669503331, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(stepperContainerView)
        stepperContainerView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: self.frame.height)
        
        addSubview(logoutButton)
        logoutButton.anchor(left: leftAnchor, right: rightAnchor,
                            paddingLeft: 32, paddingRight: 32)
        logoutButton.centerY(inView: self)
        logoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func addCart() {
        print("Add Cart")
    }
    
    // MARK: - Helpers
    
}
