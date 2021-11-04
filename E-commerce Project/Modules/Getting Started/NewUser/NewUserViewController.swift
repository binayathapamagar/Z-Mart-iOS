//
//  NewUserViewController.swift
//  E-commerce Project
//
//  Created by Binaya on 22/10/2021.
//

import UIKit

class NewUserViewController: UIViewController {

    //MARK: - @IBOutlets
    
    @IBOutlet weak var changeProfilePictureButton: UIButton!
    @IBOutlet weak var profilePictureImage: UIImageView!
    @IBOutlet weak var uploadPictureButton: UIButton!
    @IBOutlet weak var welcomeMessage: UILabel!
    
    //MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Instance methods
    
    private func setup() {
        setupImage()
        setupButtons()
        setupWelcomeMessage()
    }
    
    private func setupImage() {
        profilePictureImage.layer.cornerRadius = profilePictureImage.frame.height / 2
    }
    
    private func setupButtons() {
        changeProfilePictureButton.layer.cornerRadius = 20
        uploadPictureButton.layer.cornerRadius = 26
    }
    
    private func setupWelcomeMessage() {
        guard let user = UserManager.shared.getUsers().first else { return }
        welcomeMessage.text = "Hello " + user.name.capitalized
    }
    
    func showImagePicker(selectedSource: UIImagePickerController.SourceType) {
        
        guard UIImagePickerController.isSourceTypeAvailable(selectedSource) else {
            print("Source type not available")
            return
        }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = selectedSource
        imagePickerController.allowsEditing = false
        present(imagePickerController, animated: true, completion: nil)
        
    }

    //MARK: - @IBAction methods

    @IBAction func changeProfilePictureButtonTapped(_ sender: UIButton) {
        
        let imagePickerAlertController = UIAlertController(title: "Select an image", message: "Select an image using one of the following ways", preferredStyle: .actionSheet)
        let cameraButton = UIAlertAction(title: "Camera", style: .default) { action in
            self.showImagePicker(selectedSource: .camera)
        }
        let libraryButton = UIAlertAction(title: "Photo library", style: .default) { action in
            self.showImagePicker(selectedSource: .photoLibrary)
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        imagePickerAlertController.addAction(cameraButton)
        imagePickerAlertController.addAction(libraryButton)
        imagePickerAlertController.addAction(cancelButton)
        
        present(imagePickerAlertController, animated: true, completion: nil)
        
    }
    
    @IBAction func uploadPictureButtonTapped(_ sender: UIButton) {
        
        /// #TODO - Add user selected image to the user's profile.

        if let navController = navigationController {
            let productsViewController = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(identifier: "ProductsViewController")
            navController.pushViewController(productsViewController, animated: true)
        }
    }
    
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        if let navController = navigationController {
            let productsViewController = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(identifier: "ProductsViewController")
            navController.pushViewController(productsViewController, animated: true)
        }
    }
    
}

//MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate extension

extension NewUserViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[.originalImage] as? UIImage {
            profilePictureImage.image = selectedImage.circleMask
        }else {
            print("Selected image is not available.")
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}

//MARK: - UIImage extension

extension UIImage {
    var circleMask: UIImage? {
        let square = CGSize(width: min(size.width, size.height), height: min(size.width, size.height))
        let imageView = UIImageView(frame: .init(origin: .init(x: 0, y: 0), size: square))
        imageView.contentMode = .scaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width / 2
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
