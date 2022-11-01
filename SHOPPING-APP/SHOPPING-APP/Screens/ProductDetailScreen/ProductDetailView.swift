//
//  ProductViewModel.swift
//  SHOPPING-APP
//
//  Created by AKIN on 30.10.2022.
//


import UIKit

final class ProductDetailView: UIView {
    
    // MARK: - Properties
    
    var viewModel: ProductViewModel? {
        didSet { configure() }
    }
    
    weak var delegate: ProductCellDelegate?
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.image = UIImage(named: "jacket")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var titleContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
        view.layer.cornerRadius = 12
    
        let stack = UIStackView(arrangedSubviews: [titleLabel, priceLabel])
        stack.axis = .vertical
        stack.spacing = 6
        
        view.addSubview(stack)
        stack.centerX(inView: view)
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.text = "Wind Breaker Jacket"
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.text = "39.99$"
        return label
    }()
    
    private lazy var iconView: UIView = {
        let view = UIView()
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.centerY(inView: view)
        
        view.backgroundColor = .white
        view.setDimensions(height: 40, width: 40)
        view.layer.cornerRadius = 40 / 2
        return view
    }()
    
    private lazy var iconImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "text.quote")
        iv.clipsToBounds = true
        iv.setDimensions(height: 28, width: 28)
        iv.tintColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
        return iv
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 10
        label.textColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
        return label
    }()
    
    lazy var addCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapCart), for: .touchUpInside)
        return button
    }()
    
    lazy var stepperContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
    
        let stack = UIStackView(arrangedSubviews: [stepper, stepperLabel])
        stack.axis = .horizontal
        stack.spacing = 20
        
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
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        configureViewComponents()
    }
    
    // MARK: - Methods
    
    func configureViewComponents() {
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        
        addSubview(imageView)
        imageView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 250)
        
        addSubview(titleContainerView)
        titleContainerView.anchor(top: imageView.bottomAnchor,
                                  left: leftAnchor, right: rightAnchor,
                     paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 70)
        
        let stack = UIStackView(arrangedSubviews: [iconView, descriptionLabel])
        stack.spacing = 8
        stack.axis = .vertical
        stack.alignment = .leading
        
        addSubview(stack)
        stack.anchor(top: titleContainerView.bottomAnchor,
                                  left: leftAnchor, right: rightAnchor,
                     paddingTop: 16, paddingLeft: 16, paddingRight: 16, height: 150)
        
        addSubview(stepperContainerView)
        stepperContainerView.anchor(top: stack.bottomAnchor, left: leftAnchor,
                                    right: rightAnchor, paddingTop: 10, paddingLeft: 0,
                                    paddingBottom: 0, paddingRight: 0, width: 0,
                                    height: 20)
        
        
        addSubview(addCartButton)
        addCartButton.anchor(left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingLeft: 32, paddingBottom: 10, paddingRight: 32, height: 50)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        priceLabel.text = viewModel.price + "$"
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        imageView.sd_setImage(with: viewModel.imageUrl)
    }
    
    @objc func didTapCart() {
        guard let viewModel = viewModel else { return }
        let controller = ProductCell()
        delegate?.cell(controller, addedCart: viewModel.product)
    }
}

