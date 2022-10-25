//
//  OnboardingViewController.swift
//  SHOPPING-APP
//
//  Created by AKIN on 25.10.2022.
//

import UIKit

final class OnboardingViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var onboardCollectionView: UICollectionView!
    
    private var imageViews = [UIImageView]()
    private var items: [OnboardingItem] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupItems()
        setupCellNib()
        setupCollectionView()
        setupPageControl()
        setupImageViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }

    // MARK: - Helpers
    
    private func setupItems() {
        items = OnboardingItem.items
    }
    
    private func setupImageViews() {
        items.forEach { item in
            let imageView = UIImageView(image: item.image)
            imageView.contentMode = .scaleAspectFill
            imageView.alpha = 0.0
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.clipsToBounds = true
            containerView.addSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.8),
                imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
            ])
            imageViews.append(imageView)
        }
        imageViews.first?.alpha = 1.0
        containerView.bringSubviewToFront(onboardCollectionView)
    }
    
    private func setupCollectionView() {
        onboardCollectionView.delegate = self
        onboardCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        onboardCollectionView.collectionViewLayout = layout
        onboardCollectionView.isPagingEnabled = true
        onboardCollectionView.showsHorizontalScrollIndicator = false
    }
    
    func setupCellNib() {
        let nibname = UINib(nibName: "OnboardingCollectionViewCell", bundle: nil)
        self.onboardCollectionView.register(nibname, forCellWithReuseIdentifier: "cellId")
    }
    
    private func getCurrentIndex() -> Int {
        return Int(onboardCollectionView.contentOffset.x / onboardCollectionView.frame.width)
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = items.count
    }
    
    private func showItem(at index: Int) {
        pageControl.currentPage = index
        let shouldHide = index == items.count - 1
        nextButton.isHidden = shouldHide
        skipButton.isHidden = shouldHide
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let index = getCurrentIndex()
        let fadeInAlpha = (x - collectionViewWidth * CGFloat(index)) / collectionViewWidth
        let fadeOutAlpha = CGFloat(1 - fadeInAlpha)
        
        let canShow = (index < items.count - 1)
        guard canShow else { return }
        
        imageViews[index].alpha = fadeOutAlpha
        imageViews[index + 1].alpha = fadeInAlpha
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = getCurrentIndex()
        showItem(at: index)
    }
    
    var collectionViewWidth: CGFloat {
        return onboardCollectionView.frame.size.width
    }
    
    private func showMainApp() {
        let controller = LoginViewController()
        navigationController?.pushViewController(controller, animated: true)
        if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = controller
            /// animation
            UIView.transition(with: window, duration: 0.6,
                              options: .transitionCrossDissolve,
                              animations: nil, completion: nil)
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let nextRow = getCurrentIndex() + 1
        let nextIndexPath = IndexPath(row: nextRow, section: 0)
        onboardCollectionView.scrollToItem(at: nextIndexPath, at: .left, animated: true)
        showItem(at: nextRow)
    }
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        didTapExploreButton()
    }
}

    // MARK: - UICollectionViewDataSource

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = onboardCollectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! OnboardingCollectionViewCell
        let shouldShow = indexPath.item == items.count - 1
        cell.showExploreButton(shouldShow: shouldShow)
        let item = items[indexPath.item]
        cell.delegate = self
        cell.configure(with: item)
        return cell
    }
}

    // MARK: - UICollectionViewDelegate

extension OnboardingViewController: UICollectionViewDelegate {
    
}

    // MARK: - UICollectionViewDelegateFlowLayout

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return onboardCollectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension OnboardingViewController: OnboardingCollectionViewCellDelegate {
    func didTapExploreButton() {
        showMainApp()
    }
}
