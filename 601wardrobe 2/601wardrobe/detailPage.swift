//
//  detailPage.swift
//  601wardrobe
//
//  Created by Tommy Zheng on 10/24/17.
//  Copyright © 2017 Tommy Zheng. All rights reserved.
//

import UIKit
import os.log
import Firebase
import FirebaseAuth
import FirebaseDatabase
import CoreML

enum Species {
    case Dress
    case Heel
    case Shoe
    case Tee
    case Trouser
}

class detailPage: UIViewController ,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var itemNameText: UITextField!
    @IBOutlet weak var itemDetailText: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var itemTypeLabel: UILabel!
    
    var ref: DatabaseReference?
    var user = Auth.auth().currentUser
    
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
            picker.delegate = self
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
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    //var items: Items?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemNameText.delegate = self
        itemDetailText.delegate = self
        
        if let item = item {
            itemNameText.text = item.name
            itemDetailText.text = item.detail
            photoImageView.image = item.photo
            itemTypeLabel.text = item.type
        }
        
     ref = Database.database().reference()
        
        updateSaveButtonState()
        // Do any additional setup after loading the view.
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
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
        let type = itemTypeLabel.text ?? ""
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        item = Item(name: name, photo: photo, detail: detail, pref: 5, type: type)
        
        
        self.ref?.child("users").child((user?.uid)!).setValue(["Detail": detail, "Name": name, "Type": type])
    }
    
    //MARK: Actions

    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any])
    {
        guard let selectedImage = info["UIImagePickerControllerEditedImage"] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        photoImageView.image = selectedImage
        let species = self.predict(image: selectedImage)
        
        //itemDetailText.text = self.resultString(species: species)
        itemTypeLabel.text = self.resultString(species: species)
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
        
   
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = itemNameText.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    
    
    ///////////////Machine Learning Implemented/////////////////////

    private let ml = modelclothings()
    private let trainedImageSize = CGSize(width: 200, height: 200)
    
    func predict(image: UIImage) -> Species? {
        do {
            if let resizedImage = resize(image: image, newSize: trainedImageSize),  let pixelBuffer = resizedImage.pixelBufferGray(width: 200, height: 200) {
                let prediction = try ml.prediction(data: pixelBuffer)
                    
                if prediction.species[0].intValue == 1 {
                    return .Dress
                } else if prediction.species[1].intValue == 1 {
                    return .Heel
                } else if prediction.species[2].intValue == 1 {
                    return .Shoe
                } else if prediction.species[3].intValue == 1 {
                    return .Tee
                } else if prediction.species[4].intValue == 1 {
                    return .Trouser
                }
        }
        } catch {
            print("Error while doing predictions: \(error)")
        }
        
        return nil
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func resultString(species: Species?) -> String {
        if let species = species {
            if species == .Dress {
                return "dress"
            } else if species == .Heel {
                return "heel"
            } else if species == .Shoe {
                return "shoe"
            } else if species == .Tee {
                return "t-shirt"
            } else if species == .Trouser {
                return "trouser"
            }
        }
        
        return "doesn't belong to any of the categories"
    }
    
    private func convertImageToGrayScale(image: UIImage) -> UIImage? {
        // Create image rectangle with current image width/height
        let heightInPoints = image.size.height
        let heightInPixels = heightInPoints * image.scale
        
        let widthInPoints = image.size.width
        let widthInPixels = widthInPoints * image.scale
        let imageRect: CGRect = CGRect(x:0,y:0, width:widthInPixels, height:heightInPixels)
        
        // Grayscale color space
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceGray()
        
        // Create bitmap content with current image size and grayscale colorspace
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        //let bitmapInfo = CGBitmapInfo(CGImageAlphaInfo.None.rawValue)
        guard let context = CGContext.init(data: nil, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent:8, bytesPerRow: 0, space: colorSpace, bitmapInfo: UInt32(bitmapInfo.rawValue)) else {
            // cannot create context - handle error
            fatalError("Unexpected error")
        }
        
        // Draw image into current context, with specified rectangle using previously defined context (with grayscale colorspace)
        image.draw(in: imageRect)
        
        // Create bitmap image info from pixel data in current context
        let imageRef: CGImage = context.makeImage()!
        
        // Create a new UIImage object
        let newImage: UIImage = UIImage(cgImage: imageRef)
        
        // Return the new grayscale image
        return newImage
    }
    
    
}
