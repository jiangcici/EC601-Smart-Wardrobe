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
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        let isPresentingInAddItemMode = presentingViewController is
            UINavigationController
        
        if isPresentingInAddItemMode {
            dismiss(animated: true, completion: nil)
        }
        
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The detailPage is not inside a navigation controller.")
        }
    }
    
    
    var item: Item?
    
    
    @IBAction func shootPhoto(_ sender: UIButton) {
        let picker = UIImagePickerController()
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
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    //var items: Items?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemNameText.delegate = self
        itemDetailText.delegate = self
        
        if let item = item {
            itemNameText.text = item.name
            itemDetailText.text = item.name
            photoImageView.image = item.photo
        }
        
        //updateSaveButtonState()
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

    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any])
    {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
        
   
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Private Methods
    
//    private func updateSaveButtonState() {
//        // Disable the Save button if the text field is empty.
//        let text = itemNameText.text ?? ""
//        saveButton.isEnabled = !text.isEmpty
//    }
    
}
