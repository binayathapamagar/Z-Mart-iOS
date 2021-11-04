//
//  SignInViewController.swift
//  E-commerce Project
//
//  Created by Binaya on 21/10/2021.
//

import UIKit

class SignInViewController: UIViewController {

    //MARK: - @IBOutlets
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - Instance properties
    
    private var eyeImageTapped = false

    
    //MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Instance methods
    
    private func setup() {
        setupButton()
        setupLogoImage()
        setupTextField()
    }
    
    private func setupButton() {
        signInButton.layer.cornerRadius = 26
    }
    
    private func setupLogoImage() {
        logoImage.layer.cornerRadius = logoImage.frame.height / 2
    }
    
    private func setupTextField() {
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 17.0)
        ])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 17.0)
        ])
        
        setupPasswordTextFieldRightView()
        
    }
    
    private func setupPasswordTextFieldRightView() {
        
        let eyeImageView = UIImageView()
        eyeImageView.image = UIImage(systemName: "eye.slash.fill")
        eyeImageView.tintColor = .lightGray
        
        let contentView = UIView()
        contentView.addSubview(eyeImageView)
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(systemName: "eye.slash.fill")!.size.width, height: UIImage(systemName: "eye.slash.fill")!.size.height)
        
        eyeImageView.frame = CGRect(x: -10, y: 0, width: UIImage(systemName: "eye.slash.fill")!.size.width, height: UIImage(systemName: "eye.slash.fill")!.size.height)
        
        passwordTextField.rightView = eyeImageView
        passwordTextField.rightViewMode = .always
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(eyeImageTapped(tapGestureRecognizer:)))
        eyeImageView.isUserInteractionEnabled = true
        eyeImageView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc private func eyeImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        let tappedEyeImage = tapGestureRecognizer.view as! UIImageView
        if eyeImageTapped {
            eyeImageTapped = false
            tappedEyeImage.image = UIImage(systemName: "eye.fill")
            passwordTextField.isSecureTextEntry = false
        }else {
            eyeImageTapped = true
            tappedEyeImage.image = UIImage(systemName: "eye.slash.fill")
            passwordTextField.isSecureTextEntry = true
        }
        
    }
    
    private func showErrorAlert(with message: String = "Both fields are required!") {
        let errorAlert = UIAlertController(title: "ERROR", message: message, preferredStyle: .alert)
        let errorAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        errorAlert.addAction(errorAction)
        present(errorAlert, animated: true, completion: nil)
    }
    

    
    //MARK: - @IBAction methods

    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        guard let email = emailTextField!.text?.trimmingCharacters(in: .whitespaces).lowercased() else {return}
        guard let password = passwordTextField!.text?.trimmingCharacters(in: .whitespaces).lowercased() else {return}
        
        if email.isEmpty && password.isEmpty {
            showErrorAlert()
        }else if email.isEmpty {
            showErrorAlert(with: "Username field is required! Please fill it")
        }else if password.isEmpty{
            showErrorAlert(with: "Password field is required! Please fill it")
        }else if !email.isValidEmail {
            showErrorAlert(with: "Please enter a valid email! For example: 'user@email.com'")
        }
        
        guard let user = UserManager.shared.getUsers().first else {
            showErrorAlert(with: "No user is registered yet in our app.")
            return
        }
        
        let userEmail = user.email
        let userPassword = user.password
        
        if email != userEmail && password != userPassword {
            showErrorAlert(with: "Invalid credentials!")
        }else if email != userEmail {
            showErrorAlert(with: "Invalid Email!")
        }else if password != userPassword {
            showErrorAlert(with: "Invalid Password!")
        }else {
            
            if let navController = navigationController {
                let newUserViewController = UIStoryboard(name: "NewUser", bundle: nil).instantiateViewController(identifier: "NewUserViewController")
                navController.pushViewController(newUserViewController, animated: true)
            }
            
        }
        
    }
    
    @IBAction func forgotPasswordTapped(_ sender: UIButton) {
        if let navController = navigationController {
            let forgotPasswordViewController = UIStoryboard(name: "ForgotPassword", bundle: nil).instantiateViewController(identifier: "ForgotPasswordViewController")
            navController.pushViewController(forgotPasswordViewController, animated: true)
        }
    }
    
}
