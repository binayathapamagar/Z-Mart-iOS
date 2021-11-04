//
//  WishlistTableViewCell.swift
//  E-commerce Project
//
//  Created by Binaya on 26/10/2021.
//

import UIKit

class WishlistTableViewCell: UITableViewCell {

    //MARK: - @IBOutlets

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    var addToCartButtonTapped: (()->())?
    
    //MARK: - Lifecycle methods

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Instance methods

    private func setupCell() {
        self.layer.cornerRadius = 30
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        addToCartButtonTapped?()
    }
    
}
