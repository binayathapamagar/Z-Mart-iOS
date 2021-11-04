//
//  GetStartedViewController.swift
//  E-commerce Project
//
//  Created by Binaya on 21/10/2021.
//

import UIKit

class GetStartedViewController: UIViewController {

    //MARK: - @IBOutlets
    
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
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setupButton() {
        getStartedButton.layer.cornerRadius = 10
    }
    
    //MARK: - @IBAction methods

    @IBAction func getStartedTapped(_ sender: UIButton) {
        if let navController = navigationController {
            let welcomeViewController = UIStoryboard(name: "Welcome", bundle: nil).instantiateViewController(identifier: "WelcomeViewController")
            navController.pushViewController(welcomeViewController, animated: true)
        }
    }
    
}
