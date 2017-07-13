//
//  EditPinViewController.swift
//  PinIt!
//
//  Created by Robo Atenaga on 7/12/17.
//  Copyright © 2017 Robo Atenaga. All rights reserved.
//

import UIKit

class EditPinViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    var pin : Pin? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtName.text = pin!.name!
        imageView.image = UIImage(data: pin!.image! as Data)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        
    }

    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(pin!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
}
