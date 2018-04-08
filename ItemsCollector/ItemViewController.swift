//
//  ItemViewController.swift
//  ItemsCollector
//
//  Created by Mandeep Sarangal on 2018-04-07.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // Image of the item
    @IBOutlet weak var itemImage: UIImageView!
    
    // Name of item
    @IBOutlet weak var itemName: UITextField!
    
    // image picker to pick image from library or take a new pic
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // image picker is going to use these Interfaces
        imagePicker.delegate = self
    }
    
    // Click event when user wants to select image from the gallery
    @IBAction func photosTapped(_ sender: Any) {
        // set image source
        imagePicker.sourceType = .photoLibrary
        
        //open the image brwoser screen
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // there can be other image types that can be selected, other than original image
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // set the image to imageview
        itemImage.image = selectedImage
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // Click event when user wants to use camera
    @IBAction func cameraTapped(_ sender: Any) {
    imagePicker.sourceType = .camera
    }
    
    // Click event to add the item in collection
    @IBAction func addTapped(_ sender: Any) {
        
        // get Core data context
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // create new core data Item object
        let item = Item(context: context)
        item.title = itemName.text
        item.image = UIImagePNGRepresentation(itemImage.image!)
        
        // save the item in Core data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // go to previous viewController
        navigationController!.popViewController(animated: true)
    }

}
