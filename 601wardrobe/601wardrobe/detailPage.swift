//
//  ItemViewControler.swift
//  601wardrobe
//
//  Created by Tommy Zheng on 10/24/17.
//  Copyright © 2017 Tommy Zheng. All rights reserved.
//

import UIKit
import os.log

class ItemViewController: UIViewController ,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemNameText: UITextField!
    @IBOutlet weak var itemDetailText: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //var items: Items?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemNameText.delegate = self
        itemDetailText.delegate = self
        // Do any additional setup after loading the view.
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        itemNameLabel.text = itemNameText.text
    }
    
    //MARK: Actions

    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard.
        itemNameText.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        // Configure the destination view controller only when the save button is pressed.
//        guard let button = sender as? UIBarButtonItem, button === saveButton else {
//            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
//            return
//        }
//
//        let name = itemNameText.text ?? ""
//        let detail = itemDetailText.text ?? ""
//        let photo = photoImageView.image
//
//        //items = Items(name: name, detail: detail, photo: photo)
//
//    }

}
