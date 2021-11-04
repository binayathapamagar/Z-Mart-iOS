//
//  EditProfileViewController.swift
//  E-commerce Project
//
//  Created by Binaya on 27/10/2021.
//

import UIKit

class EditProfileViewController: UIViewController {

    //MARK: - @IBOutlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    
    //MARK: - Instance properties
    
    private var eyeImageTapped = false
    
    //MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deSetupNavBar()
    }
    
    //MARK: - Instance methods
    
    private func setup(){
        setupButton()
        setupPasswordTextFieldRightView()
    }

    private func setupButton() {
        updateButton.layer.cornerRadius = 26
    }
    
    private func showErrorAlert(with message: String = "All fields are required!") {
        let errorAlert = UIAlertController(title: "ERROR", message: message, preferredStyle: .alert)
        let errorAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        errorAlert.addAction(errorAction)
        present(errorAlert, animated: true, completion: nil)
    }
    
    private func setupNavBar() {
        navigationItem.title = "Edit Profile"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func deSetupNavBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
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
        if self.eyeImageTapped {
            self.eyeImageTapped = false
            tappedEyeImage.image = UIImage(systemName: "eye.fill")
            passwordTextField.isSecureTextEntry = false
        }else {
            self.eyeImageTapped = true
            tappedEyeImage.image = UIImage(systemName: "eye.slash.fill")
            passwordTextField.isSecureTextEntry = true
        }
        
    }
    
    //MARK: - @IBAction methods
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        
        guard let user = UserManager.shared.getUsers().first else {
            showErrorAlert(with: "User found as nil!")
            return
        }
        
        guard let name = nameTextField!.text?.trimmingCharacters(in: .whitespaces).lowercased() else {return}
        guard let email = emailTextField!.text?.trimmingCharacters(in: .whitespaces).lowercased() else {return}
        guard let number = numberTextField!.text?.trimmingCharacters(in: .whitespaces).lowercased() else {return}
        guard let password = passwordTextField!.text?.trimmingCharacters(in: .whitespaces).lowercased() else {return}
        
        if name.isEmpty && email.isEmpty && number.isEmpty {
            showErrorAlert()
        }else if name.isEmpty {
            showErrorAlert(with: "Username field is required! Please fill it")
        }else if email.isEmpty{
            showErrorAlert(with: "Email field is required! Please fill it")
        }else if number.isEmpty{
            showErrorAlert(with: "Number field is required! Please fill it")
        }else if password.isEmpty{
            showErrorAlert(with: "password field is required! Please fill it")
        }else if !email.isValidEmail {
            showErrorAlert(with: "Please enter a valid email! For example: 'user@email.com'")
        }else if number.count < 10 || number.count > 10 {
            showErrorAlert(with: "Please enter a valid 10 digit phone number available in Nepal!")
        }else if user.name == name {
            showErrorAlert(with: "New name cannot be the same as the old name")
        }else if user.password == password {
            showErrorAlert(with: "New password cannot be the same as the old password")
        }else if user.email == email {
            showErrorAlert(with: "New email cannot be the same as the old email")
        }else if user.phone == number {
            showErrorAlert(with: "New phone cannot be the same as the old phone")
        }else {
            
            guard let _ = Int(number) else {
                self.showErrorAlert(with: "Please enter a valid phone number!")
                return
            }
            
            user.name = name
            user.email = email
            user.phone = number
            user.password = password
            
            UserManager.shared.updateUser(user: user)
            
            if let navController = navigationController {
                navController.popViewController(animated: true)
            }
            
        }
        
    }
    
}
