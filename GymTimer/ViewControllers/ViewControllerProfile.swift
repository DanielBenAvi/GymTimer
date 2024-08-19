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
    
    @IBOutlet weak var uploadButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    var imageLink: String = ""
    
    var user: User!
    
    var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapGesture)
        
        // Disable tap gesture initially
        tapGesture.isEnabled = false
        
        uploadButton.isEnabled = false
        
        // Set a placeholder image
        imageView.image = UIImage(named: "profile")
        
        let userId = AuthManager.shared.getCurrentUserId()
        
        Task {
            do {
                guard let userFromDB = await RealTimeManager.shared.getUserFromDB(userId: userId) else {
                    enableImageTap()  // Enable tap if user not found
                    return
                }
                
                user = userFromDB
                nameLabel.text = user.name
                emailLabel.text = user.email
                
                
                imageLink = user.image
                
                if !imageLink.isEmpty {
                    loadImage { [weak self] image in
                        guard let self = self else { return }
                        
                        DispatchQueue.main.async {
                            if let image = image {
                                self.imageView.image = image
                            } else {
                            }
                            self.enableImageTap()  // Enable tap after attempting to load image
                        }
                    }
                } else {
                    enableImageTap()  // Enable tap if there's no image link
                }
            }
        }
    }
    
    func enableImageTap() {
        tapGesture.isEnabled = true
        uploadButton.isEnabled = true
    }
    
    
    @objc func imageTapped() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
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
            self.addAlert(title: "Error", message: "Error downloading image.")
            // Keep the default "profile" image
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            self.uploadButton.isEnabled = false
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
                self.imageLink = imageName
                self.uploadButton.isEnabled = true
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
                DispatchQueue.main.async {
                    self.addAlert(title: "Error", message: "Failed to download image.")
                }
                completion(nil)
            } else if let imageData = data, let image = UIImage(data: imageData) {
                completion(image)
            } else {
                DispatchQueue.main.async {
                    self.addAlert(title: "Error", message: "Failed to download image.")
                }
                completion(nil)
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func lougout(_ sender: Any) {
        AuthManager.shared.logout()
        self.moveToNewScreen(storyboard_id: "ViewControllerLogin", fullScreen: true)
    }
    
    
    @IBAction func updateUser(_ sender: Any) {
        let userId = user.id
        
        // Update the user object with the new image name
        user.image = imageLink
        
        // Convert user object to dictionary
        let userDict = user.toDictionary()
        
        // Update the user in the database
        Task {
            do {
                try await RealTimeManager.shared.updateUser(userId: userId, userData: userDict)
                addAlert(title: "Success", message: "User profile updated successfully.")
            } catch {
                addAlert(title: "Error", message: "Failed to update user profile. Please try again.")
            }
        }
    }
    
}
