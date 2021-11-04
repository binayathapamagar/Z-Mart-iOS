//
//  CartTableViewCell.swift
//  E-commerce Project
//
//  Created by Binaya on 26/10/2021.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    //MARK: - @IBOutlets
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    var quantityButtonTapped: ((_ sign: String)->())?
    
    //MARK: - Lifecycle methods

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Instance methods
    
    private func setup() {
        setupCell()
    }
    
    private func setupCell() {
        self.layer.cornerRadius = 30
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }
    
    @IBAction func quantityButtonTapped(_ sender: UIButton) {
        
        if sender.imageView?.image == UIImage(systemName: "plus") {
            quantityButtonTapped?("plus")
        }else {
            quantityButtonTapped?("minus")
        }
        
    }
    
}
