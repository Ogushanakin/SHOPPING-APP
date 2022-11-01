//
//  ProductCell.swift
//  SHOPPING-APP
//
//  Created by AKIN on 1.11.2022.
//

import UIKit
import SDWebImage

final class SearchScreenCell: UITableViewCell {
    
    // MARK: - Properties
    
    var viewModel: ProductViewModel? {
        didSet { configure() }
    }
    
    let productImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.image = UIImage(named: "jacket")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var titleContainerView: UIView = {
        let view = UIView()
    
        let stack = UIStackView(arrangedSubviews: [titleLabel, priceLabel])
        stack.axis = .vertical
        stack.spacing = 6
        stack.alignment = .leading
        stack.distribution = .equalCentering
        
        view.addSubview(stack)
        stack.centerX(inView: view)
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 8, weight: .semibold)
        label.numberOfLines = 1
        label.text = "Wind Breaker Jacket"
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "39.99$"
        return label
    }()
    
    lazy var addCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(didTapCart), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price + "$"
        productImage.sd_setImage(with: viewModel.imageUrl)
    }
    
    func configureUI() {
        let stack = UIStackView(arrangedSubviews: [productImage, titleContainerView])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        
        addSubview(stack)
        stack.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: bottomAnchor,
                     right: rightAnchor, paddingTop: 8, paddingBottom: 8, paddingRight: 6)
        
        addSubview(addCartButton)
        addCartButton.anchor(left: safeAreaLayoutGuide.leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor,
                             right: rightAnchor, paddingLeft: 200, paddingBottom: 30,
                             paddingRight: 22, height: 35)
    }
    
    @objc func didTapCart() {
        
    }
}
