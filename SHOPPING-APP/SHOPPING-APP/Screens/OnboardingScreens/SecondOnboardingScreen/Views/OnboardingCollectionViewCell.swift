//
//  OnboardingCollectionViewCell.swift
//  SHOPPING-APP
//
//  Created by AKIN on 25.10.2022.
//

import UIKit

protocol OnboardingCollectionViewCellDelegate: AnyObject {
    func didTapExploreButton()
}

final class OnboardingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var exploreButton: UIButton!
    
    weak var delegate: OnboardingCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func configure(with item: OnboardingItem) {
        titleLabel.text = item.title
        detailLabel.text = item.detail
    }
    
    func showExploreButton(shouldShow: Bool) {
        exploreButton.isHidden = !shouldShow
        exploreButton.layer.cornerRadius = 4
    }

    @IBAction func exploreButtonTapped(_ sender: Any) {
        delegate?.didTapExploreButton()
    }
}
