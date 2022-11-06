//
//  CartTableViewCell.swift
//  SHOPPING-APP
//
//  Created by AKIN on 30.10.2022.
//

import UIKit

final class CartTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var viewModel: ProductViewModel? {
        didSet { configure() }
    }
    
    let productImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
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
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 4
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [productImage, titleContainerView])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        
        addSubview(stack)
        stack.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingBottom: 8, paddingRight: 6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price + "$"
        productImage.sd_setImage(with: viewModel.imageUrl)
    }
}
