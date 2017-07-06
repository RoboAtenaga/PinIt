//
//  ViewController.swift
//  PinIt!
//
//  Created by Robo Atenaga on 7/6/17.
//  Copyright © 2017 Robo Atenaga. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var boards = [String]()
    @IBOutlet weak var boardsCollectionView: UICollectionView!
    let itemsPerRow: CGFloat = 3
    let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        boards.append("Roe")
        boards.append("Roe")
        boards.append("Roe")
        boards.append("Roe")
        boards.append("Roe")
        boards.append("Roe")
        boards.append("Roe")
        boards.append("Roe")
        boards.append("Roe")
        boards.append("Roe")
        boards.append("Roe")
        
        boardsCollectionView.delegate = self
        boardsCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        boardsCollectionView.backgroundColor = UIColor.clear
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "boardCell", for: indexPath)
        
        cell.backgroundColor = UIColor.black
        
        return cell
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

}

