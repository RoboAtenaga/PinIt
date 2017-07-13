//
//  AddPinViewController.swift
//  PinIt!
//
//  Created by Robo Atenaga on 7/11/17.
//  Copyright © 2017 Robo Atenaga. All rights reserved.
//

import UIKit
import  CoreData

// To use UIImagePickerController, you need to implement UIImagePickerControllerDelegate, UINavigationControllerDelegate
class AddPinViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var pinImageView: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    var boardName = ""
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        // Making UIImageView Clickable
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(tapGestureRecognizer:)))
        pinImageView.isUserInteractionEnabled = true
        pinImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pinTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let pin = Pin(context: context)
        
        pin.setValue(txtName.text!, forKey: "name")
        pin.setValue(UIImagePNGRepresentation(pinImageView.image!) as NSData?, forKey: "image")
        pin.setValue(boardName, forKey: "boardName")
        
        //or
        //pin.name = txtName.text!
        //pin.image = UIImagePNGRepresentation(pinImageView.image!) as NSData?
        // Saving to CoreData
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        // Automatically go back to previousVC after adding
        navigationController!.popViewController(animated: true)
        
    }
    
    func imageViewTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //let pinImage = tapGestureRecognizer.view as! UIImageView
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        pinImageView.image = selectedImage
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
