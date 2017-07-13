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
    @IBOutlet weak var btnPinUpdate: UIButton!
    
    @IBOutlet weak var btnDelete: UIButton!
    var pin: Pin? = nil
    var boardName = ""
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        if pin != nil{
            txtName.text = pin!.name!
            pinImageView.image = UIImage(data: pin!.image! as Data)
            
            btnPinUpdate.setTitle("Edit", for: .normal)
        }
        else{
            btnDelete.isHidden = true
        }
        
        // Making UIImageView Clickable
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(tapGestureRecognizer:)))
        pinImageView.isUserInteractionEnabled = true
        pinImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pinUpdateTapped(_ sender: Any) {
        if pin != nil{
            pin!.name = txtName.text!
            pin!.image = UIImagePNGRepresentation(pinImageView.image!) as NSData?
        }
        else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let pin2 = Pin(context: context)
            
            pin2.setValue(txtName.text!, forKey: "name")
            pin2.setValue(UIImagePNGRepresentation(pinImageView.image!) as NSData?, forKey: "image")
            pin2.setValue(boardName, forKey: "boardName")
        }
        
        // Saving to CoreData
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        // Automatically go back to previousVC after adding
        navigationController!.popViewController(animated: true)
        
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(pin!)
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
