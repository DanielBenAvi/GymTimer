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
    
    var imageLink: String = ""
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            // Set a placeholder image
            imageView.image = UIImage(named: "profile")
        
        let userId = AuthManager.shared.getCurrentUserId()
        
        Task {
                do {
                    guard let userFromDB = await RealTimeManager.shared.getUserFromDB(userId: userId) else {
                        print("User not found in database")
                        return
                    }
                    
                    print("User from DB: \(String(describing: userFromDB.toDictionary()))")
                    imageLink = userFromDB.image
                    
                    print("Image link: \(imageLink)")
                    
                    // Load the image if imageLink is not empty
                    if !imageLink.isEmpty {
                        loadImage { [weak self] image in
                            guard let self = self else { return }
                            
                            DispatchQueue.main.async {
                                if let image = image {
                                    self.imageView.image = image
                                } else {
                                    print("Failed to load image, keeping default profile image")
                                }
                            }
                        }
                    }
                }
            }
    }
    
    func loadProfileImage() async {
        guard !imageLink.isEmpty else {
            // imageLink is empty, keep the default "profile" image
            return
        }
        
        do {
            let storage = Storage.storage()
            let storageRef = storage.reference(forURL: imageLink)
            
            let data = try await storageRef.data(maxSize: 5 * 1024 * 1024)
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        } catch {
            print("Error downloading image: \(error)")
            // Keep the default "profile" image
        }
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
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        // Use the imageLink property
        let imageRef = storageRef.child("images/\(imageLink)")
        
        imageRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "Failed to load image. Please try again.")
                }
                completion(nil)
            } else if let imageData = data, let image = UIImage(data: imageData) {
                completion(image)
            } else {
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "Failed to convert data to image.")
                }
                completion(nil)
            }
        }
    }
    
    @IBAction func loadImageFromFirebase(_ sender: Any) {
        loadImage { [weak self] image in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let image = image {
                    self.imageView.image = image
                } else {
                    // The error alert is already shown in the loadImageFromFirebase function
                    print("Failed to load image")
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
