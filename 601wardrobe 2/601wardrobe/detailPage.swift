//
//  detailPage.swift
//  601wardrobe
//
//  Created by Tommy Zheng on 10/24/17.
//  Copyright © 2017 Tommy Zheng. All rights reserved.
//

import UIKit
import os.log

class detailPage: UIViewController ,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var itemNameText: UITextField!
    @IBOutlet weak var itemDetailText: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    var item: Item?
    
    let picker = UIImagePickerController()
    
    
    @IBAction func shootPhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            itemNameText.resignFirstResponder()
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        } else {
            noCamera()
        }
    }
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    @IBAction func photofromLibrary(_ sender: UIButton) {
        itemNameText.resignFirstResponder()
        picker.allowsEditing = false
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            present(picker, animated: true, completion: nil)
        } else {
            print("Can't read image from album.")
        }
    }
    
    //var items: Items?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemNameText.delegate = self
        itemDetailText.delegate = self
        picker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    //MARK: Navigation
    
    // This method lets you configure a view controller before it's presented.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = itemNameText.text ?? ""
        let photo = photoImageView.image
        let detail = itemDetailText.text ?? ""
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        item = Item(name: name, photo: photo, detail: detail, pref: 5, type: "default")
    }
    
    //MARK: Actions

//    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
//
//        // Hide the keyboard.
//        itemNameText.resignFirstResponder()
//
//        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
//        let imagePickerController = UIImagePickerController()
//
//        // Only allow photos to be picked, not taken.
//        imagePickerController.sourceType = .photoLibrary
//
//        // Make sure ViewController is notified when the user picks an image.
//        imagePickerController.delegate = self
//        present(imagePickerController, animated: true, completion: nil)
//    }
    
    //MARK: UIImagePickerControllerDelegate
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        // Dismiss the picker if the user canceled.
//        dismiss(animated: true, completion: nil)
//    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//
//        // The info dictionary may contain multiple representations of the image. You want to use the original.
//        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
//            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
//        }
//
//        // Set photoImageView to display the selected image.
//        photoImageView.image = selectedImage
//
//        // Dismiss the picker.
//        dismiss(animated: true, completion: nil)
//    }
    
    //MARK: - Delegates
    private func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
//        guard let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
//            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
//        }
//
        photoImageView.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
