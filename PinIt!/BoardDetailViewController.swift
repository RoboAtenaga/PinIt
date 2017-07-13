//
//  BoardDetailViewController.swift
//  PinIt!
//
//  Created by Robo Atenaga on 7/12/17.
//  Copyright © 2017 Robo Atenaga. All rights reserved.
//

import UIKit
import CoreData

class BoardDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblPins: UITableView!
    var boardName = ""
    var pins : [Pin] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = boardName
        tblPins.delegate = self
        tblPins.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPinsFromCoreData()
        tblPins.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblPins.dequeueReusableCell(withIdentifier: "pinCell", for: indexPath) as! PinTableViewCell
        let pin = pins[indexPath.row]
        cell.lblName?.text = pin.name!
        cell.pinImageView?.image = UIImage(data: pin.image! as Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pin = pins[indexPath.row]
        performSegue(withIdentifier: "pinDetail", sender: pin)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pinDetail"{
            let editPinVC = segue.destination as! EditPinViewController
            editPinVC.pin = sender as? Pin
        }
        else{
            let addPinVC = segue.destination as! AddPinViewController
            addPinVC.boardName = boardName
        }
    }
    
    func getPinsFromCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            let fetchPins: NSFetchRequest<NSFetchRequestResult> = Pin.fetchRequest()
            let predicate = NSPredicate(format: "%K == %@","boardName",boardName)
            fetchPins.predicate = predicate
            pins = try context.fetch(fetchPins) as! [Pin]
        } catch {
            print("Error! Oops!")
        }
    }
}
