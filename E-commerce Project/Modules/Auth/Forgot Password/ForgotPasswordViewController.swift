//
//  ForgotPasswordViewController.swift
//  E-commerce Project
//
//  Created by Binaya on 22/10/2021.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    //MARK: - @IBOutlets
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    
    //MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Instance methods
    
    private func setup() {
        setupButton()
    }
    
    private func setupButton() {
        submitButton.layer.cornerRadius = 26
    }
    
    private func showErrorAlert(with message: String = "Email field is required!") {
        let errorAlert = UIAlertController(title: "ERROR", message: message, preferredStyle: .alert)
        let errorAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        errorAlert.addAction(errorAction)
        present(errorAlert, animated: true, completion: nil)
    }
    
    //MARK: - @IBAction methods

    @IBAction func submitButtonTapped(_ sender: UIButton) {
        
        guard let email = emailTextField!.text?.trimmingCharacters(in: .whitespaces).lowercased() else {return}
        
        if email.isEmpty {
            showErrorAlert()
        }else if !email.isValidEmail {
            showErrorAlert(with: "Please enter a valid email! For example: 'user@email.com'")
        }else {
                
            if let navController = navigationController {
                navController.popViewController(animated: true)
            }
            
        }
        
    }
    
}
