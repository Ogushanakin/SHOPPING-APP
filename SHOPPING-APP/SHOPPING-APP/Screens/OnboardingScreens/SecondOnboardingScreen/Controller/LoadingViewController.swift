//
//  LoadingViewController.swift
//  SHOPPING-APP
//
//  Created by AKIN on 25.10.2022.
//

import UIKit

protocol OnboardingSeenProtocol {
    var isOnboardingSeen: Bool { get }
}

final class LoadingViewController: UIViewController,
                                    OnboardingSeenProtocol {
    var isOnboardingSeen = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showInitialScreen()
    }
    
    // MARK: - Helpers
    
    private func showInitialScreen() {
        
        if isOnboardingSeen {
            showMainApp()
        } else {
            showOnboardingScreen()
        }
    }
        
        private func showOnboardingScreen() {
            let controller = FirstOnboardingViewController()
            navigationController?.pushViewController(controller, animated: true)
            if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,
               let window = sceneDelegate.window {
                window.rootViewController = controller
                /// animation
                UIView.transition(with: window, duration: 0.7,
                                  options: .transitionCrossDissolve,
                                  animations: nil, completion: nil)
            }
        }
        
        private func showMainApp() {
            let controller = LoginViewController()
            navigationController?.pushViewController(controller, animated: true)
            if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,
               let window = sceneDelegate.window {
                window.rootViewController = controller
                /// animation
                UIView.transition(with: window, duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: nil, completion: nil)
                }
        }
}
