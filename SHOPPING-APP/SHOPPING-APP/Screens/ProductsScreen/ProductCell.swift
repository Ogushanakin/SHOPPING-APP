//
//  ProductCell.swift
//  SHOPPING-APP
//
//  Created by AKIN on 28.10.2022.
//

import UIKit

final class ProductCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var viewModel: ProductViewModel? {
        didSet { configure() }
    }
    
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
    
        let stack = UIStackView(arrangedSubviews: [titleLabel, priceLabel, addToCart])
        stack.axis = .vertical
        stack.spacing = 6
        
        view.addSubview(stack)
        stack.centerX(inView: view)
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Wind Breaker Jacket"
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "39.99$"
        return label
    }()
    
    lazy var addToCart: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "cart.badge.plus"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(addCart), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViewComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price + "$"
        imageView.sd_setImage(with: viewModel.imageUrl)
    }
    
    func configureViewComponents() {
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: self.frame.height - 80)
        
        addSubview(likeButton)
        likeButton.anchor(top: imageView.topAnchor, left: imageView.leftAnchor)
        
        addSubview(titleContainerView)
        titleContainerView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 80)
    }
    
    @objc func addCart() {
        print("Added to Cart")
    }
    
    @objc func like() {
        print("like")
    }
}
