//
//  ViewControllerProfile.swift
//  GymTimer
//
//  Created by Yaniv Ben David on 17/08/2024.
//

import Foundation
import UIKit
import FirebaseStorage

class ViewControllerProfile: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            // Set a placeholder image
            imageView.image = UIImage(named: "icon1")
        }
    
    @IBAction func selectImageTapped(_ sender: Any) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                imageView.image = selectedImage
                uploadImage(selectedImage)
            }
            dismiss(animated: true, completion: nil)
        }
    
    func uploadImage(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        // Create a unique filename
        let imageName = UUID().uuidString + ".jpg"
        let imageRef = storageRef.child("images/\(imageName)")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
            } else {
                print("Image uploaded successfully")
                // Here you can save the download URL if needed
                imageRef.downloadURL { (url, error) in
                    if let downloadURL = url {
                        print("Download URL: \(downloadURL.absoluteString)")
                        // Save this URL to your database if required
                    }
                }
            }
        }
    }
    
    @IBAction func loadImageFromFirebase(_ sender: Any) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        // Replace "images/your_image.jpg" with the path to your image in Firebase Storage
        let imageRef = storageRef.child("images/D8DAB44A-A004-4E89-AC91-BE8F17440AF7.jpg")
        
        // Download in memory with a maximum allowed size of 10MB (10 * 1024 * 1024 bytes)
        imageRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                // Show an alert to the user
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "Failed to load image. Please try again.")
                }
            } else {
                // Data for "images/your_image.jpg" is returned
                if let imageData = data, let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error", message: "Failed to convert data to image.")
                    }
                }
            }
        }
    }

    // Helper method to show alerts
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
