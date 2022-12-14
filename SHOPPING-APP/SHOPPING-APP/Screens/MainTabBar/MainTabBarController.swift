//
//  MainTabBarController.swift
//  SHOPPING-APP
//
//  Created by AKIN on 26.10.2022.
//

import UIKit
import Firebase
import SideMenu

 class MainTabBarController: UITabBarController {
    
    private var shouldShowOnboarding = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureViewControllers()
        configureNavigationBarButtons()
        checkIfUserIsLoggedIn()
    }
    
    // MARK: - API
     
    func logout() {
        do {
            try Auth.auth().signOut()
            presentLoginController()
        } catch {
            print("DEBUG: Error signing out")
        }
    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                self.presentLoginController()
            }
        } else {
            if shouldShowOnboarding == false {
                presentOnboardingController()
            }
        }
    }
    
    fileprivate func presentLoginController() {
        let controller = LoginViewController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    fileprivate func presentOnboardingController() {
        let controller = FirstOnboardingViewController()
        controller.delegate = self
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
   
    // MARK: - Helpers
    
    private func configureViewControllers() {
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        let products = templateNavigationController(unselectedImage: UIImage(systemName: "shippingbox")!,
                                                    selectedImage: UIImage(systemName: "shippingbox")!,
                                                    title: "Products",
                                                    rootViewController: ProductsController(collectionViewLayout: layout))
        
        let search = templateNavigationController(unselectedImage: UIImage(systemName: "magnifyingglass")!,
                                                  selectedImage: UIImage(systemName: "magnifyingglass")!,
                                                  title: "Search",
                                                  rootViewController: SearchController())
        
        let profile = templateNavigationController(unselectedImage: UIImage(systemName: "person")!,
                                                   selectedImage: UIImage(systemName: "person")!,
                                                   title: "Profile",
                                                   rootViewController: ProfileController())
        
        viewControllers = [products, search, profile]
    }
    
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, title: String, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        navigationItem.title = "SHOPPING APP"
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.tabBarItem.title = title
        tabBar.tintColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
        return nav
    }
    
    private func configureNavigationBarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(showSideMenu))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(handleShowCart))
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
    }
    
    // MARK: - Selectors
    
    @objc func handleShowCart() {
        let controller = CartController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .popover
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc func showSideMenu() {
        let controller = SideMenuViewController()
        let menu = SideMenuNavigationController(rootViewController: controller)
        present(menu, animated: true)
    }
    
}

extension MainTabBarController: OnboardingControllerDelegate {
    func controllerWantsToDismiss(_ controller: FirstOnboardingViewController) {
        shouldShowOnboarding.toggle()
    }
}
