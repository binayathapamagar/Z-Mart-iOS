//
//  WishlistViewController.swift
//  E-commerce Project
//
//  Created by Binaya on 26/10/2021.
//

import UIKit

class WishlistViewController: UIViewController {

    //MARK: - @IBOutlets
    
    @IBOutlet weak var wishlistTableView: UITableView!
    
    //MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshTableView()
        setupNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unSetNavBar()
    }
    
    //MARK: - Instance methods

    private func setup() {
        setupTableView()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "Your Wishlist"
    }
    
    private func unSetNavBar() {
        navigationController?.navigationBar.barTintColor = K.AppColor.primaryColor
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupTableView() {
        wishlistTableView.dataSource = self
        wishlistTableView.delegate = self
        wishlistTableView.rowHeight = 150
    }
    
    private func refreshTableView() {
        wishlistTableView.reloadData()
    }
    
    func showAlertMessage(with title: String, and message: String) {
        let successAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        successAlert.addAction(cancelAction)
        present(successAlert, animated: true, completion: nil)
    }

}

//MARK: - UITableViewDataSource extension

extension WishlistViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let products = WishlistManager.shared.getWishlistProducts()
        return products.count != 0 ? products.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let products = WishlistManager.shared.getWishlistProducts()
        if products.count == 0 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Your wishlist is empty."
            cell.imageView?.image = UIImage(named: "emptyWishlist")
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.selectionStyle = .none
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.wishlistCellIdentifier, for: indexPath) as! WishlistTableViewCell
        let product = WishlistManager.shared.getWishlistProducts()[indexPath.row]
        cell.productImage.image = UIImage(named: product.images.first!)
        cell.productTitle.text = product.name
        cell.addToCartButtonTapped = {
            guard let message = CartManager.shared.addToCart(product, from: UpdateCartFrom.Wishlist) else { return }
            self.showAlertMessage(with: "Wishlist", and: message)
        }
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    
}

//MARK: - UITableViewDelegate extension

extension WishlistViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let products = WishlistManager.shared.getWishlistProducts()
        
        if products.count != 0 {
            
            let item = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
                
                let deleteAlertController = UIAlertController(title: "Confirmation", message: "Are you sure you want to remove \(products[indexPath.row].name) from your wishlist?", preferredStyle: .alert)
                
                let yesAction = UIAlertAction(title: "Yes", style: .default) { yesAction in
                    
                    WishlistManager.shared.deleteFromWishlist(at: indexPath.row)
                    self.wishlistTableView.reloadData()
                    
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

                deleteAlertController.addAction(yesAction)
                deleteAlertController.addAction(cancelAction)
                
                self.present(deleteAlertController, animated: true, completion: nil)
                
            }
            
            item.image = UIImage(named: "deleteIcon")

            let swipeActions = UISwipeActionsConfiguration(actions: [item])
        
            return swipeActions
        }
        
        return nil
        
    }
    
    
}
