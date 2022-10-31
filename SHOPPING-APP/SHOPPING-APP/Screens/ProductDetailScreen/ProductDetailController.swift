//
//  ProductDetailController.swift
//  SHOPPING-APP
//
//  Created by AKIN on 28.10.2022.
//

import UIKit
import SDWebImage

final class ProductDetailViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: ProductViewModel? {
        didSet { configure() }
    }
    
    private let detailView = ProductDetailView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
        
        configureNavBar()
    }

    // MARK: - Methods
    
    func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(closeDetail))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.222751677, green: 0.3736387491, blue: 0.3669503331, alpha: 1)
        navigationItem.title = "Product Detail"
    }
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        detailView.priceLabel.text = viewModel.price + "$"
        detailView.titleLabel.text = viewModel.title
        detailView.descriptionLabel.text = viewModel.description
        detailView.imageView.sd_setImage(with: viewModel.imageUrl)
    }
    
    @objc func closeDetail() {
        dismiss(animated: true, completion: nil)
    }


}
