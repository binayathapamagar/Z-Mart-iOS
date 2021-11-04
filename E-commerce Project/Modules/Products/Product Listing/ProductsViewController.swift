//
//  ProductsViewController.swift
//  E-commerce Project
//
//  Created by Binaya on 21/10/2021.
//

import UIKit

class ProductsViewController: UIViewController {

    //MARK: - @IBOutlets
    
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Instance properties
    
    let productManager = ProductManager()
    var tempProducts = ProductManager().getProducts()
    
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
        setupTableView()
    }

    private func setupTableView() {
        productsTableView.dataSource = self
        productsTableView.delegate = self
        productsTableView.rowHeight = 200
        productsTableView.separatorColor = .gray
        searchBar.delegate = self
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = K.appTitle
            
        let profileBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(profileBarButtonTapped), image: UIImage(named: "user")!)
        let cartBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(cartBarButtonTapped), image: UIImage(systemName: "cart.fill")!)
        let wishlistButtonItem = UIBarButtonItem.menuButton(self, action: #selector(wishlistButtonTapped), image: UIImage(systemName: "heart")!)
                
        navigationItem.rightBarButtonItems = [profileBarButtonItem, cartBarButtonItem, wishlistButtonItem]
    }
    
    private func unSetNavBar() {
        navigationController?.navigationBar.barTintColor = K.AppColor.primaryColor
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc private func profileBarButtonTapped() {
        let userProfileViewController = UIStoryboard(name: "UserProfile", bundle: nil).instantiateViewController(identifier: "UserProfileViewController") as! UserProfileViewController
        navigationController?.pushViewController(userProfileViewController, animated: true)
    }
    
    @objc private func cartBarButtonTapped() {
        let cartViewController = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(identifier: "CartViewController") as! CartViewController
        navigationController?.pushViewController(cartViewController, animated: true)
    }
    
    @objc private func wishlistButtonTapped() {
        let wishlistViewController = UIStoryboard(name: "Wishlist", bundle: nil).instantiateViewController(identifier: "WishlistViewController") as! WishlistViewController
        navigationController?.pushViewController(wishlistViewController, animated: true)
    }

}

//MARK: - UITableViewDataSource extension

extension ProductsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let product = tempProducts[indexPath.row]
        let productCell = tableView.dequeueReusableCell(withIdentifier: K.productCellIdentifier, for: indexPath) as! ProductsTableViewCell
        productCell.productNameLabel.text = product.name
        productCell.productImageView.image = UIImage(named: product.images.first!)
        productCell.productPriceLabel.text = product.priceAs2DpString
        productCell.ratingsView.rating = product.ratings
        
        return productCell
    }
    
}

//MARK: - UITableViewDelegate extension

extension ProductsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let productDetailsViewController = UIStoryboard(name: "ProductDetails", bundle: nil).instantiateViewController(identifier: "ProductDetailsViewController") as! ProductDetailsViewController
        productDetailsViewController.selectedProduct = tempProducts[indexPath.row]
        navigationController?.pushViewController(productDetailsViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}

//MARK: - UISearchBarDelegate extension

extension ProductsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if tempProducts.count != productManager.getProducts().count {
            tempProducts = ProductManager().getProducts()
        }
        
        let userSearchedText = searchBar.text!.trimmingCharacters(in: .whitespaces).lowercased()
        if userSearchedText.isEmpty {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            tempProducts = productManager.getProducts()
            productsTableView.reloadData()
        }else {
            tempProducts = tempProducts.filter {
                $0.name.lowercased().trimmingCharacters(in: .whitespaces).contains(userSearchedText)
            }
            productsTableView.reloadData()
        }
    }
    
}
