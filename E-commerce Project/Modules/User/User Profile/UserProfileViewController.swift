//
//  UserProfileViewController.swift
//  E-commerce Project
//
//  Created by Binaya on 21/10/2021.
//

import UIKit

class UserProfileViewController: UIViewController {

    //MARK: - @IBOutlets
    
    @IBOutlet weak var userProfilePicture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var seeOrderHistoryView: UIView!
    
    //MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        setupUserInformation()
    }
    
    //MARK: - Instance methods
    
    private func setup() {
        setupUserProfilePicture()
        setupSeeOrdersView() 
    }
    
    private func setupUserProfilePicture() {
        userProfilePicture.layer.cornerRadius = userProfilePicture.frame.width / 2
    }
    
    private func setupUserInformation() {
        let user = UserManager.shared.getUsers().first!
        name.text = user.name.capitalized
        email.text = user.email
        number.text = user.phone
    }
    
    private func setupNavBar() {
            
        let editProfileBarButton = UIBarButtonItem(title: "Edit Profile", style: .plain, target: self, action: #selector(editProfileButtonTapped))
        editProfileBarButton.tintColor = .white
                
        navigationItem.rightBarButtonItem = editProfileBarButton
    }
    
    @objc private func editProfileButtonTapped() {
        
        if let navController = navigationController {
            let editProfileViewController = UIStoryboard(name: "EditProfile", bundle: nil).instantiateViewController(identifier: "EditProfileViewController")
            navController.pushViewController(editProfileViewController, animated: true)
        }
        
    }
    
    private func setupSeeOrdersView() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(seeHistoryViewTapped(tapGestureRecognizer:)))
        
        seeOrderHistoryView.isUserInteractionEnabled = true
        seeOrderHistoryView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc private func seeHistoryViewTapped(tapGestureRecognizer: UITapGestureRecognizer) {
                
        if let navController = navigationController {
            let orderSuccessfulViewController = UIStoryboard(name: "OrderHistory", bundle: nil).instantiateViewController(identifier: "OrderHistoryViewController")
            navController.pushViewController(orderSuccessfulViewController, animated: true)
            
        }
                
    }
    
    //MARK: - @IBAction methods

}
