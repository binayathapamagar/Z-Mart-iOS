//
//  OrderHistoryViewController.swift
//  E-commerce Project
//
//  Created by Binaya on 27/10/2021.
//

import UIKit

class OrderHistoryViewController: UIViewController {

    //MARK: - @IBOutlets
    
    @IBOutlet weak var orderTableView: UITableView!
    
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
        orderTableView.dataSource = self
        orderTableView.rowHeight = 200
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "Order History"
    }
    
    private func unSetNavBar() {
        navigationController?.navigationBar.barTintColor = K.AppColor.primaryColor
        navigationController?.navigationBar.tintColor = .white
    }
        
}

//MARK: - UITableViewDataSource extension

extension OrderHistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let userOrderHistoryCount = UserManager.shared.getUsers().first?.orderHistory.count else { return 1 }
        return userOrderHistoryCount != 0 ? userOrderHistoryCount : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        if let ordersCount = UserManager.shared.getUsers().first?.orderHistory.count {
                        
            if ordersCount == 0 {
                let cell = UITableViewCell()
                cell.textLabel?.text = "You have yet to make an order."
                cell.imageView?.image = UIImage(named: "empty")
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.adjustsFontSizeToFitWidth = true
                cell.selectionStyle = .none
                return cell
            }
                        
        }
        
        let order = UserManager.shared.getUsers().first!.orderHistory[indexPath.row]
        let cell = orderTableView.dequeueReusableCell(withIdentifier: K.orderCellIdentifier, for: indexPath) as! OrderTableViewCell
        
        cell.orderId.text = String(indexPath.row + 1)
        cell.totalPrice.text = order.totalAmountAsAString
        cell.totalProductsCount.text = String(order.products.count)
        cell.orderDate.text = order.formattedDate
        cell.selectionStyle = .none
        
        return cell
        
    }
    
}

