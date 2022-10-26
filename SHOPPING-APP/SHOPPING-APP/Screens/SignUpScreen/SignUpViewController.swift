//
//  SignUpController.swift
//  SHOPPING-APP
//
//  Created by AKIN on 26.10.2022.
//

import UIKit
import Firebase


final class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = SignUpViewModel()
    weak var delegate: AuthenticationDelegate?

    
    private let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logo_transparent")
        return iv
    }()
    
    private lazy var emailContainerView: UIView = {
        return InputContainerView(image: UIImage(systemName: "envelope"),
                                  textField: emailTextField)
    }()
    
    private lazy var fullnameContainerView: UIView = {
        return InputContainerView(image: UIImage(systemName: "person"),
                                  textField: fullnameTextField)
    }()
    
    private lazy var usernameContainerView: UIView = {
        return InputContainerView(image: UIImage(systemName: "person"),
                                  textField: usernameTextField)
    }()
    
    private lazy var passwordContainerView: InputContainerView = {
        return InputContainerView(image: UIImage(systemName: "lock"),
                                  textField: passwordTextField)
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let fullnameTextField = CustomTextField(placeholder: "Full Name")
    private let usernameTextField = CustomTextField(placeholder: "Username")
    
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 0.6343905215)
        button.setHeight(height: 50)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    private lazy var alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ",
                                                        attributes: [.font: UIFont.systemFont(ofSize: 16),
                                                                     .foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: "Log In",
                                                  attributes: [.font: UIFont.boldSystemFont(ofSize: 16),
                                                               .foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNotificationsObservers()
    }
    
    // MARK: - Selectors
    
    @objc func handleSignUp() {

        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: failed to create user with error: \(error.localizedDescription)")
                return
            }
            guard let uid = result?.user.uid else { return }
            
            let values = ["email": email, "fullname": fullname]
            
            Database.database().reference().child("users").child(uid).updateChildValues(values) { (err, ref) in
                if let error = error {
                    print("DEBUG: failed to upload user data with error: \(error.localizedDescription)")
                    return
                }
                print("DEBUG: Successfully created user and upload user info...")
            }
        }

        let controller = MainTabBarController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc func handleShowLogin() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == fullnameTextField {
            viewModel.fullname = sender.text
        } else if sender == usernameTextField {
            viewModel.username = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
            
            checkFormStatus()
        }
    }
    
    @objc func keyboardWillShow() {
        if view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 88
        }
    }
    
    @objc func keyboardWillHide() {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        configureGradientBackground()
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        iconImage.setDimensions(height: 250, width: 300)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   fullnameContainerView,
                                                   usernameContainerView,
                                                   passwordContainerView,
                                                   signUpButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor,
                     right: view.rightAnchor, paddingTop: 32, paddingLeft: 32,
                     paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
    }
    
    func configureNotificationsObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
   
}

extension SignUpViewController: AuthenticationControllerProtocol {
    
    func checkFormStatus() {
        if viewModel.formIsValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 1)
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = #colorLiteral(red: 0.1220499948, green: 0.1906306446, blue: 0.2015277445, alpha: 0.6332005381)
        }
    }
}
