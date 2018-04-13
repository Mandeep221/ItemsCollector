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
    
    // delete button
    @IBOutlet weak var deleteButton: UIButton!
    
    // ad update button
    @IBOutlet weak var addUpdateButton: UIButton!
    
    // Name of item
    @IBOutlet weak var itemName: UITextField!
    
    // image picker to pick image from library or take a new pic
    var imagePicker = UIImagePickerController()
    
    // If this variable is passed, means its update screen, if not, its new item screen
    var sentItem : Item? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // image picker is going to use these Interfaces
        imagePicker.delegate = self
        
        // Check which view to show
        if sentItem != nil
        {
            print("We have a game")
            itemImage.image = UIImage(data: sentItem!.image as! Data)
            itemName.text = sentItem!.title
            addUpdateButton.setTitle("Update", for: .normal)
        }else{
           deleteButton.isHidden = true
        }
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
        // set image source
        imagePicker.sourceType = .camera
        
        //open the image brwoser screen
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Click event to add the item in collection
    @IBAction func addTapped(_ sender: Any) {
        
        // get Core data context
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if sentItem != nil
        {
            sentItem!.title = itemName.text
            sentItem?.image = UIImagePNGRepresentation(itemImage.image!)
        }else
        {
            // create new core data Item object
            let item = Item(context: context)
            item.title = itemName.text
            item.image = UIImagePNGRepresentation(itemImage.image!)
        }
        
        // save the item in Core data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // go to previous viewController
        navigationController!.popViewController(animated: true)
    }

    @IBAction func deleteTapped(_ sender: Any) {
        // get Core data context
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Delete the object from Core Data
        context.delete(sentItem!)
        
        // save the item in Core data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // go to previous viewController
        navigationController!.popViewController(animated: true)
    }
}
