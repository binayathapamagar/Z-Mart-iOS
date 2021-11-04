//
//  SignUpViewController.swift
//  E-commerce Project
//
//  Created by Binaya on 21/10/2021.
//

import UIKit

class SignUpViewController: UIViewController {
   
    //MARK: - @IBOutlets
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
   
    //MARK: - Instance properties
    
    private var passwordEyeImageTapped = false
    private var confirmPasswordEyeImageTapped = false
    
    //MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavbar()
    }
    
    //MARK: - Instance methods
    
    private func setup() {
        setupButton()
        setupLogoImage()
        setupTextField()
    }
    
    private func setupButton() {
        nextButton.layer.cornerRadius = 26
    }
    
    private func setupLogoImage() {
        logoImageView.layer.cornerRadius = logoImageView.frame.height / 2
    }
    
    private func setupTextField() {
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 17.0)
        ])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 17.0)
        ])
        mobileTextField.attributedPlaceholder = NSAttributedString(string: "Mobile", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 17.0)
        ])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 17.0)
        ])
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Confrim password", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 17.0)
        ])

        setupPasswordTextFieldRightView()
        setupConfirmPasswordTextFieldRightView()
        
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
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(passwordEyeImageTapped(tapGestureRecognizer:)))
        eyeImageView.isUserInteractionEnabled = true
        eyeImageView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    private func setupConfirmPasswordTextFieldRightView() {
        
        let eyeImageView = UIImageView()
        eyeImageView.image = UIImage(systemName: "eye.slash.fill")
        eyeImageView.tintColor = .lightGray
        
        let contentView = UIView()
        contentView.addSubview(eyeImageView)
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(systemName: "eye.slash.fill")!.size.width, height: UIImage(systemName: "eye.slash.fill")!.size.height)
        
        eyeImageView.frame = CGRect(x: -10, y: 0, width: UIImage(systemName: "eye.slash.fill")!.size.width, height: UIImage(systemName: "eye.slash.fill")!.size.height)
        
        confirmPasswordTextField.rightView = eyeImageView
        confirmPasswordTextField.rightViewMode = .always
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(confirmPasswordEyeImageTapped(tapGestureRecognizer:)))
        eyeImageView.isUserInteractionEnabled = true
        eyeImageView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc private func passwordEyeImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        let tappedEyeImage = tapGestureRecognizer.view as! UIImageView
        if passwordEyeImageTapped {
            passwordEyeImageTapped = false
            tappedEyeImage.image = UIImage(systemName: "eye.fill")
            passwordTextField.isSecureTextEntry = false
        }else {
            passwordEyeImageTapped = true
            tappedEyeImage.image = UIImage(systemName: "eye.slash.fill")
            passwordTextField.isSecureTextEntry = true
        }
        
    }
    
    @objc private func confirmPasswordEyeImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        let tappedEyeImage = tapGestureRecognizer.view as! UIImageView
        if confirmPasswordEyeImageTapped {
            confirmPasswordEyeImageTapped = false
            tappedEyeImage.image = UIImage(systemName: "eye.fill")
            confirmPasswordTextField.isSecureTextEntry = false
        }else {
            confirmPasswordEyeImageTapped = true
            tappedEyeImage.image = UIImage(systemName: "eye.slash.fill")
            confirmPasswordTextField.isSecureTextEntry = true
        }
        
    }

    private func showErrorAlert(with message: String = "All fields are required!") {
        let errorAlert = UIAlertController(title: "ERROR", message: message, preferredStyle: .alert)
        let errorAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        errorAlert.addAction(errorAction)
        present(errorAlert, animated: true, completion: nil)
    }
    
    
    private func setupNavbar() {
     
//        let titleImageView = UIImageView(image: UIImage(named: "logo"))
//        titleImageView.translatesAutoresizingMaskIntoConstraints = false
//        titleImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        titleImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        navigationItem.titleView = titleImageView
        
    }
    
    //MARK: - @IBAction methods

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        guard let name = nameTextField!.text?.trimmingCharacters(in: .whitespaces).lowercased() else {return}
        guard let email = emailTextField!.text?.trimmingCharacters(in: .whitespaces).lowercased() else {return}
        guard let mobile = mobileTextField!.text?.trimmingCharacters(in: .whitespaces).lowercased() else {return}
        guard let password = passwordTextField!.text?.trimmingCharacters(in: .whitespaces).lowercased() else {return}
        guard let confirmPassword = confirmPasswordTextField!.text?.trimmingCharacters(in: .whitespaces).lowercased() else {return}
        
        if name.isEmpty && email.isEmpty && mobile.isEmpty && password.isEmpty && confirmPassword.isEmpty {
            showErrorAlert()
        }else if name.isEmpty {
            showErrorAlert(with: "Username field is required! Please fill it")
        }else if email.isEmpty{
            showErrorAlert(with: "email field is required! Please fill it")
        }else if mobile.isEmpty{
            showErrorAlert(with: "mobile field is required! Please fill it")
        }else if password.isEmpty{
            showErrorAlert(with: "password field is required! Please fill it")
        }else if confirmPassword.isEmpty{
            showErrorAlert(with: "confirmPassword field is required! Please fill it")
        }else if password != confirmPassword {
            showErrorAlert(with: "Password and confirm password must be the same!")
        }else if !email.isValidEmail {
            showErrorAlert(with: "Please enter a valid email! For example: 'user@email.com'")
        }else if mobile.count < 10 || mobile.count > 10 {
            showErrorAlert(with: "Please enter a valid 10 digit phone number available in Nepal!")
        }else {
            
            guard let _ = Int(mobile) else {
                self.showErrorAlert(with: "Please enter a valid phone number!")
                return
            }
            
            let user = User(name: name, email: email, phone: mobile, password: password)
            UserManager.shared.addNewUser(user)
            
            if let navController = navigationController {
                let signInViewController = UIStoryboard(name: "SignIn", bundle: nil).instantiateViewController(identifier: "SignInViewController")
                navController.pushViewController(signInViewController, animated: true)
            }
        }
        
    }
    
}
