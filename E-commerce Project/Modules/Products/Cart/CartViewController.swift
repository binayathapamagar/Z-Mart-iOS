//
//  CartViewController.swift
//  E-commerce Project
//
//  Created by Binaya on 21/10/2021.
//

import UIKit

class CartViewController: UIViewController {

    //MARK: - @IBOutlets
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var checkoutbutton: UIButton!
    @IBOutlet weak var totalAmount: UILabel!
    
    
    //MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
        setupTotalAmountLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        toggleCheckButtonVisibility()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unSetNavBar()
    }
    
    //MARK: - Instance methods

    private func setup() {
        setupCheckoutButton()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func unSetNavBar() {
        navigationController?.navigationBar.barTintColor = K.AppColor.primaryColor
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupCheckoutButton() {
        checkoutbutton.layer.cornerRadius = 25
        checkoutbutton.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        checkoutbutton.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        checkoutbutton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        let spacing: CGFloat = 12
        checkoutbutton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing);
        checkoutbutton.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0);
    }
    
    private func toggleCheckButtonVisibility() {
        let products = CartManager.shared.getCartProducts()
        if products.count == 0 {
            checkoutbutton.isHidden = true
        }else {
            checkoutbutton.isHidden = false
        }
    }
    
    private func setupTableView() {
        cartTableView.dataSource = self
        cartTableView.delegate = self
        cartTableView.rowHeight = 180
    }
    
    func refreshTableViewData() {
        cartTableView.reloadData()
        setupTotalAmountLabel()
    }
    
    private func setupTotalAmountLabel() {
        var price = 0.0
        price = CartManager.shared.getCartProducts().reduce(0, {$0 + ($1.product.price * Double($1.quantity))})
        totalAmount.text = "Rs." + formatMoney(with: price)
    }
    
    private func formatMoney(with price: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedPrice = numberFormatter.string(from: NSNumber(value: price))
        guard let validPrice = formattedPrice else { return String(format: "%.0f", price)}
        return validPrice
    }
    
    private func showErrorAlert(with title: String,  message: String = "Both fields are required!") {
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let errorAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        errorAlert.addAction(errorAction)
        present(errorAlert, animated: true, completion: nil)
    }
    
    //MARK: - @IBAction methods

    @IBAction func checkoutButtonTapped(_ sender: UIButton) {
       
        UserManager.shared.addNewOrder()
        CartManager.shared.removeAllItems()
        refreshTableViewData()
        
        if let navController = navigationController {
            let orderSuccessfulViewController = UIStoryboard(name: "Order", bundle: nil).instantiateViewController(identifier: "OrderSuccessfulViewController")
            navController.pushViewController(orderSuccessfulViewController, animated: true)
            
        }
        
    }
}

//MARK: - UITableViewDataSource extension

extension CartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let products = CartManager.shared.getCartProducts()
        return products.count != 0 ? products.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let products = CartManager.shared.getCartProducts()
        if products.count == 0 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Your cart is empty."
            cell.imageView?.image = UIImage(named: "emptyCart")
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.selectionStyle = .none
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cartCellIdentifier, for: indexPath) as! CartTableViewCell
        let cartProduct = CartManager.shared.getCartProducts()[indexPath.row]
        
        cell.productImage.image = UIImage(named: cartProduct.product.images.first ?? "bag.fill")
        cell.productName.text = cartProduct.product.name
        cell.productPrice.text = cartProduct.product.priceAs2DpString
        cell.quantityLabel.text = String(cartProduct.quantity)
        cell.quantityButtonTapped = { sign in
            let product = CartManager.shared.getCartProducts()[indexPath.row].product
            if sign == "plus" {
                let _ = CartManager.shared.addToCart(product, from: UpdateCartFrom.Cart)
                self.refreshTableViewData()
            }else {
                CartManager.shared.decreaseQuantity(product)
                self.refreshTableViewData()
            }
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
}

//MARK: - UITableViewDataSource extension

extension CartViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let products = CartManager.shared.getCartProducts()
        
        if products.count != 0 {
            
            let item = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
                
                let deleteAlertController = UIAlertController(title: "Confirmation", message: "Are you sure you want to remove \(products[indexPath.row].product.name) from your cart?", preferredStyle: .alert)
                
                let yesAction = UIAlertAction(title: "Yes", style: .default) { yesAction in
                    
                    CartManager.shared.deleteFromCart(at: indexPath.row)
                    self.toggleCheckButtonVisibility()
                    self.refreshTableViewData()
                    
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

