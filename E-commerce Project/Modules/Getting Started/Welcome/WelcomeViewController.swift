//
//  WelcomeViewController.swift
//  E-commerce Project
//
//  Created by Binaya on 22/10/2021.
//

import UIKit

class WelcomeViewController: UIViewController {

    //MARK: - @IBOutlets
        
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var getStartedButton: UIButton!
    
    //MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }

    //MARK: - Instance methods
    
    private func setup() {
        setupButton()
        setupLogoImage()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = K.AppColor.primaryColor
        navigationController?.navigationBar.tintColor = .white
    }
    
    
    private func setupButton() {
        getStartedButton.layer.cornerRadius = 26
    }
    
    private func setupLogoImage() {
        logoImage.layer.cornerRadius = logoImage.frame.height / 2
    }
    
    //MARK: - @IBAction methods
    

    @IBAction func getStartedTapped(_ sender: UIButton) {
        if let navController = navigationController {
            let signUpViewController = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(identifier: "SignUpViewController")
            navController.pushViewController(signUpViewController, animated: true)
        }
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        if let navController = navigationController {
            let signInViewController = UIStoryboard(name: "SignIn", bundle: nil).instantiateViewController(identifier: "SignInViewController")
            navController.pushViewController(signInViewController, animated: true)
        }
    }

}
