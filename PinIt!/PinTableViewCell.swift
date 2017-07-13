//
//  PinTableViewCell.swift
//  PinIt!
//
//  Created by Robo Atenaga on 7/13/17.
//  Copyright © 2017 Robo Atenaga. All rights reserved.
//

import UIKit

class PinTableViewCell: UITableViewCell {

    @IBOutlet var pinImageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
