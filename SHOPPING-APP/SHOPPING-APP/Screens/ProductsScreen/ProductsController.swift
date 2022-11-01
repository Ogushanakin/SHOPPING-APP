//
//  ProductsController.swift
//  SHOPPING-APP
//
//  Created by AKIN on 26.10.2022.
//

import UIKit
import Firebase

private let reuseIdentifier = "ProductCell"

final class ProductsController: UICollectionViewController {
    
    // MARK: - Properties
    
    private var products = [ProductModel]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchProducts()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(HeroHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeroHeaderView.identifier)
    }
    
    // MARK: - API
    
    func fetchProducts() {
        ProductService.fetchProducts { products in
            self.products = products
            self.collectionView.reloadData()
        }
    }
    
}

    // MARK: - CollectionViewDELEGATE-DATASOURCE
extension ProductsController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCell
        cell.viewModel = ProductViewModel(product: products[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = ProductDetailViewController()
        controller.viewModel = ProductViewModel(product: products[indexPath.row])
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .popover
        self.present(nav, animated: true, completion: nil)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffSet = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffSet
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

    // MARK: - CollectionViewDELEGATEFLOWLAYOUT
extension ProductsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 36) / 2
        return CGSize(width: width, height: 250)
    }
    
    // MARK: - CollectionViewHEADER
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeroHeaderView.identifier, for: indexPath)
        }
        
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeroHeaderView.identifier, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 400)
    }
}

extension ProductsController: ProductCellDelegate {
    func cell(_ cell: ProductCell, addedCart product: ProductModel) {
        
        cell.viewModel?.product.didAddCart.toggle()
        
        if product.didAddCart {
            ProductService.addCart(product: product) { _ in
                cell.addToCart.setImage(UIImage(systemName: "cart.fill.badge.minus"), for: .normal)
            }
        } else {
            
        }
    }
}
