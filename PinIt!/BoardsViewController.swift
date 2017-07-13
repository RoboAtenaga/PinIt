//
//  ViewController.swift
//  PinIt!
//
//  Created by Robo Atenaga on 7/6/17.
//  Copyright © 2017 Robo Atenaga. All rights reserved.
//

import UIKit

class BoardsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var boardsCollectionView: UICollectionView!
    var boards : [Board] = []
    let itemsPerRow: CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        boardsCollectionView.delegate = self
        boardsCollectionView.dataSource = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getBoardsFromCoreData()
        boardsCollectionView.backgroundColor = UIColor.clear
        boardsCollectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "boardCell", for: indexPath) as! BoardCollectionViewCell
        
        cell.cellLabel?.text = boards[indexPath.row].name!
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBoard = boards[indexPath.row].name!
        performSegue(withIdentifier: "boardDetail", sender: selectedBoard)
    }
    
    // Changing size of a cell
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    // Returns the spacing between the cells, headers, and footers
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // Controls the spacing between each line in the layout, match the padding at the left and right.
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    // + tapped
    @IBAction func addTapped(_ sender: Any) {
        // creating new alert dialog
        let alertController = UIAlertController(title: "New Board", message: "Enter Board Name", preferredStyle: .alert)
        // adding a textfield to it
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter name"
        }
        // creating the enter action
        let enterAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            let name = alertController.textFields?[0].text
            // creating a new board
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let board = Board(context: context)
            board.name = name
            // Saving to CoreData
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
        // adding the enter action to alert dialog
        alertController.addAction(enterAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Get boardsfrom core data
    func getBoardsFromCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            boards = try context.fetch(Board.fetchRequest()) as! [Board]
        } catch {
            print("Error! Oops!")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! BoardDetailViewController
        nextVC.boardName = (sender as? String)!
    }

}

