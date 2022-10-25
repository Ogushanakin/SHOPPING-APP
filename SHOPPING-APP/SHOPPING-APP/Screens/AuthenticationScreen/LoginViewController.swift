//
//  MainController.swift
//  SHOPPING-APP
//
//  Created by AKIN on 25.10.2022.
//

import UIKit

final class LoginViewController: UIViewController,
                                 OnboardingSeenProtocol{
    
    var isOnboardingSeen = true
    
    private let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logo_transparent")
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        configureGradientBackground()
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        iconImage.setDimensions(height: 180, width: 200)
    }
}
