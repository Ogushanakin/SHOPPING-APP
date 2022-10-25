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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureGradientBackground()
    }
}
