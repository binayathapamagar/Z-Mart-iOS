//
//  ProductsTableViewCell.swift
//  E-commerce Project
//
//  Created by Binaya on 23/10/2021.
//

import UIKit
import Cosmos

class ProductsTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var ratingsView: CosmosView!
    
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
        setupImage()
    }
    
    private func setupCell() {
        self.layer.cornerRadius = 30
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }
    
    private func setupImage() {
        productImageView.layer.cornerRadius = 40
    }
    
}
