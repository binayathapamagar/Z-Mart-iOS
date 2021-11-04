//
//  OrderSuccessfulViewController.swift
//  E-commerce Project
//
//  Created by Binaya on 21/10/2021.
//

import UIKit

class OrderSuccessfulViewController: UIViewController {

    //MARK: - @IBOutlets
    
    @IBOutlet weak var seeOrdersButton: UIButton!
    
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
        unSetNavBar()
    }
    
    //MARK: - Instance methods
    
    private func setup() {
        setupButton()
    }
    
    private func setupButton() {
        seeOrdersButton.layer.cornerRadius = 26
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func unSetNavBar() {
        navigationController?.navigationBar.barTintColor = K.AppColor.primaryColor
        navigationController?.navigationBar.tintColor = .white
    }
    
    //MARK: - @IBAction methods

    @IBAction func seeOrdersButtonTapped(_ sender: UIButton) {
        
        if let navController = navigationController {
            let orderHistoryViewController = UIStoryboard(name: "OrderHistory", bundle: nil).instantiateViewController(identifier: "OrderHistoryViewController")
            navController.pushViewController(orderHistoryViewController, animated: true)
            
        }

    }
    
    @IBAction func backToHomeTapped(_ sender: UIButton) {
        let viewcontrollers = self.navigationController?.viewControllers
        viewcontrollers?.forEach({ (vc) in
            if  let productsViewController = vc as? ProductsViewController {
                self.navigationController!.popToViewController(productsViewController, animated: true)
            }
        })
    }
    
}
