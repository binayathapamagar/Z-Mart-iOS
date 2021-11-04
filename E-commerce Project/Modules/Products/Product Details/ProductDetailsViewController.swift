//
//  ProductDetailsViewController.swift
//  E-commerce Project
//
//  Created by Binaya on 21/10/2021.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    //MARK: - @IBOutlets
    
    @IBOutlet weak var productImageCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var currentCellIndex = 0
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productRatings: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var quantityView: UIView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var decreaseQuantityButton: UIButton!
    @IBOutlet weak var increaseQuantityButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var infoSegmentedControl: UISegmentedControl!
    @IBOutlet weak var productDescription: UILabel!
    
    //MARK: - Instance methods
    
    var selectedProduct: Product? 
    var timer: Timer?
    var wishlistBarButton: UIBarButtonItem?
    
    //MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupProductQuantity()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        checkForProductInWishlist()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unSetNavBar()
    }
    
    //MARK: - Instance methods

    private func setup() {
        setupCollectionView()
        startImageTimer()
        setupProductDetailOutlets()
        setupAddToCartButton()
        setupQuantityView()
        setupSegmentedControl()
    }
    
    private func setupCollectionView() {
        productImageCollectionView.dataSource = self
        productImageCollectionView.delegate = self
    }
    
    private func setupNavBar() {
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
        guard let product = selectedProduct else { return }
        
        let wishlistImageName = product.inWishlist ? "heart.fill" : "heart"
        let wishlistBarButtonItem = UIBarButtonItem(image: UIImage(systemName: wishlistImageName), style: .plain, target: self, action: #selector(wishlistBarButtonTapped))
        navigationItem.rightBarButtonItem = wishlistBarButtonItem
        wishlistBarButton = wishlistBarButtonItem
        
    }
    
    @objc private func wishlistBarButtonTapped() {
        
        if selectedProduct!.inWishlist {
            
            selectedProduct!.inWishlist = false
            wishlistBarButton?.image = UIImage(systemName: "heart")
            wishlistBarButton?.tintColor = .black
                        
            let productsInWishlist = WishlistManager.shared.getWishlistProducts()
            guard let productIndex = productsInWishlist.firstIndex(where: { $0.id == selectedProduct!.id }) else { return }
            
            WishlistManager.shared.deleteFromWishlist(at: productIndex)

        }else {
            
            selectedProduct!.inWishlist = true
            wishlistBarButton?.image = UIImage(systemName: "heart.fill")
            wishlistBarButton?.tintColor = .red

            WishlistManager.shared.addToWishlist(selectedProduct!)
            
        }
        
    }
    
    private func checkForProductInWishlist() {
        let productsInWishlist = WishlistManager.shared.getWishlistProducts()
        if productsInWishlist.firstIndex(where: { $0.id == selectedProduct!.id }) != nil {
            selectedProduct?.inWishlist = true
            navigationItem.rightBarButtonItem?.tintColor = .red
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
        }
    }
    
    private func unSetNavBar() {
        navigationController?.navigationBar.barTintColor = K.AppColor.primaryColor
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func startImageTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(changeDisplayedImage), userInfo: nil, repeats: true)
    }
    
    @objc private func changeDisplayedImage() {
        
        guard let product = selectedProduct else { return }
        if currentCellIndex < product.images.count - 1{
            currentCellIndex += 1
        }else {
            currentCellIndex = 0
        }
        pageControl.currentPage = currentCellIndex
        productImageCollectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        
    }
    
    private func setupProductDetailOutlets() {
        guard let product = selectedProduct else { return }
        productName.text = product.name
        productPrice.text = product.priceAs2DpString
        productRatings.text = String(product.ratings)
        productDescription.text = product.description
    }
    
    private func setupAddToCartButton() {
        addToCartButton.layer.cornerRadius = 28
        addToCartButton.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        addToCartButton.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        addToCartButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        let spacing: CGFloat = 12
        addToCartButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing);
        addToCartButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0);
    }
    
    private func setupProductQuantity() {
        
        guard let product = selectedProduct else { return }
        let products = CartManager.shared.getCartProducts()
        if let cartProductIndex = products.firstIndex(where: { $0.product.id == product.id }) {
            let cartProduct = products[cartProductIndex]
            quantityLabel.text = String(cartProduct.quantity)
            addToCartButton.setTitle("UPDATE CART", for: .normal)
        }else {
            addToCartButton.setTitle("ADD TO CART", for: .normal)
        }
    
    }
    
    private func setupQuantityView() {
        quantityView.layer.cornerRadius = 28
    }
    
    private func setupSegmentedControl() {
        
        infoSegmentedControl.setupSegment()
        
        infoSegmentedControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor : K.AppColor.primaryColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)], for: .selected)
        infoSegmentedControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)], for: .normal)
        
        if #available(iOS 13.0, *) {
            let dividerImage = UIImage(color: .white, size: CGSize(width: 1, height: 32))
            infoSegmentedControl.setBackgroundImage(UIImage(named: "w1"), for: .normal, barMetrics: .default)
            infoSegmentedControl.setBackgroundImage(UIImage(named: "w2"), for: .selected, barMetrics: .default)
            infoSegmentedControl.setDividerImage(dividerImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
            infoSegmentedControl.layer.cornerRadius = 0
            infoSegmentedControl.layer.masksToBounds = true
        }
    }
    
    func showAlertMessage(with title: String, and message: String) {
           
        let successAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        successAlert.addAction(cancelAction)
        present(successAlert, animated: true, completion: nil)
       
    }
    
    
    //MARK: - @IBAction methods
    
    @IBAction func pageValueChanged(_ sender: UIPageControl) {
    
        timer?.invalidate()
        
        switch pageControl.currentPage {
            case 0:
                currentCellIndex = 0
            case 1:
                currentCellIndex = 1
            case 2:
                currentCellIndex = 2
            default:
                currentCellIndex = 0
        }
                
        productImageCollectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        startImageTimer()
        
    }
    
    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        
        addToCartButton.setTitle("UPDATE CART", for: .normal)
        guard let quantity = Int(quantityLabel.text!) else { return }
        guard let message = CartManager.shared.addToCart(selectedProduct!, quantity: quantity, from: UpdateCartFrom.ProductDetails) else { return }
        showAlertMessage(with: "Cart", and: message)

    }
    
    @IBAction func productQuantityButtonsTapped(_ sender: UIButton) {
        
        guard let product = selectedProduct else { return }
        guard let quantity = Int(quantityLabel.text!) else { return }
        var newQuantity = quantity
        
        if sender.currentImage == increaseQuantityButton.currentImage {
            
            newQuantity = newQuantity < product.quantity ? newQuantity + 1 : newQuantity
            quantityLabel.text = String(newQuantity)
        
        }else {
            
            newQuantity = newQuantity > 1 ? newQuantity - 1 : newQuantity
            quantityLabel.text = String(newQuantity)
            
        }
        
    }
    
    @IBAction func infoSegmentedValueChanged(_ sender: UISegmentedControl) {
        infoSegmentedControl.changeUnderlinePosition()
        
        if infoSegmentedControl.selectedSegmentIndex == 0 {
        }else if infoSegmentedControl.selectedSegmentIndex == 1 {
        }else if infoSegmentedControl.selectedSegmentIndex == 2 {
        }else {
        }
        
    }
    
}

//MARK: - UICollectionViewDataSource extension

extension ProductDetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedProduct?.images.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                        
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: K.prodCollectionViewCellIdentifier, for: indexPath) as! ProductCollectionViewCell
        
        guard let product = selectedProduct else { return productCell }
        productCell.productImage.image = UIImage(named: product.images[indexPath.item])
        
        return productCell
        
    }
    
}

//MARK: - UICollectionViewDelegate extension

extension ProductDetailsViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let index = productImageCollectionView.indexPathsForVisibleItems.first?.item {
            timer?.invalidate()
            pageControl.currentPage = index
            currentCellIndex = index
            startImageTimer()
        }
    }
    
}

//MARK: - UICollectionViewFlowLayout extension

extension ProductDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
