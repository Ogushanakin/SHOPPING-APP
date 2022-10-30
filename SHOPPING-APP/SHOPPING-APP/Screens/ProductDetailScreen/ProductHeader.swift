//
//  ProductHeader.swift
//  SHOPPING-APP
//
//  Created by AKIN on 30.10.2022.
//

import UIKit

protocol ProductHeaderDelegate: AnyObject {
    func dismissController()
}

final class ProductHeader: UIView {
    
    // MARK: - Properties
    
    var product: ProductModel? {
        didSet { populateUserData() }
    }
    
    weak var delegate: ProductHeaderDelegate?
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.image = UIImage(named: "jacket")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
        button.addTarget(self, action: #selector(like), for: .touchUpInside)
        return button
    }()
    
    lazy var titleContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
    
        let stack = UIStackView(arrangedSubviews: [titleLabel, priceLabel])
        stack.axis = .vertical
        stack.spacing = 6
        
        view.addSubview(stack)
        stack.centerX(inView: view)
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 26)
        label.text = "Wind Breaker Jacket"
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "39.99$"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleDismissal() {
        delegate?.dismissController()
    }
    
    @objc func addCart() {
        print("Added to Cart")
    }
    
    @objc func like() {
        print("like")
    }
    
    // MARK: - Helpers
    
    func populateUserData() {
        guard let product = product else { return }
        
        titleLabel.text = product.title
        priceLabel.text = String(product.price)

    }
    
    func configureViewComponents() {
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        
        addSubview(imageView)
        imageView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: self.frame.height - 70)
        
        addSubview(likeButton)
        likeButton.anchor(top: imageView.topAnchor, left: imageView.leftAnchor)
        
        addSubview(titleContainerView)
        titleContainerView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 70)
    }

}
