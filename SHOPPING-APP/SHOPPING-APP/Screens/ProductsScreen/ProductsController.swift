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
    
    private let jsonService: JsonService = JsonService()
    
    private var products = [ProductModel]()
    private var mensProducts = [ProductModel]()
    private var womenProducts = [ProductModel]()
    private var electronicsProducts = [ProductModel]()
    private var jeweleriesProducts = [ProductModel]()
    
    lazy var itemsToDisplay = products
    
    lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["All", "Men", "Women", "Electronic", "Jewelery"])
        sc.selectedSegmentTintColor = #colorLiteral(red: 0.222751677, green: 0.3736387491, blue: 0.3669503331, alpha: 1)
        sc.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        return sc
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchProducts()
        fetchMenProducts()
        fetchWomenProducts()
        fetchElectronicsProducts()
        fetchJeweleriesProducts()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffSet = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffSet
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(HeroHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeroHeaderView.identifier)
        
        self.navigationItem.titleView = segmentedControl
    }
    
    // MARK: - Selectors
    
    @objc fileprivate func handleSegmentChange() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            itemsToDisplay = products
        case 1:
            itemsToDisplay = mensProducts
        case 2:
            itemsToDisplay = womenProducts
        case 3:
            itemsToDisplay = electronicsProducts
        case 4:
            itemsToDisplay = jeweleriesProducts
        default:
            itemsToDisplay = products
        }
        collectionView.reloadData()
    }
    
    // MARK: - API
    
    func fetchProducts() {
        ProductService.fetchProducts { products in
            self.products = products
            self.collectionView.reloadData()
        }
    }
    
    func fetchMenProducts() {
        ProductService.fetchMens { products in
            self.mensProducts = products
        }
    }
    
    func fetchWomenProducts() {
        ProductService.fetchWomens { products in
            self.womenProducts = products
        }
    }
    
    func fetchElectronicsProducts() {
        ProductService.fetchElectronics { products in
            self.electronicsProducts = products
        }
    }
    
    func fetchJeweleriesProducts() {
        ProductService.fetchJeweleries { products in
            self.jeweleriesProducts = products
        }
    }
    
    /* private func initService() {
        jsonService.fetchAllPosts { [weak self] (models) in
        } onFail: { (data) in
            print(data ?? "")
        }
    } */
}

    // MARK: - CollectionViewDELEGATE-DATASOURCE
extension ProductsController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsToDisplay.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCell
        cell.viewModel = ProductViewModel(product: itemsToDisplay[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = ProductDetailViewController()
        controller.viewModel = ProductViewModel(product: itemsToDisplay[indexPath.row])
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .popover
        self.present(nav, animated: true, completion: nil)
    }
    
    
}

    // MARK: - CollectionViewDelegateFlowLayout
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

    // MARK: - ProductCellDelegate

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
