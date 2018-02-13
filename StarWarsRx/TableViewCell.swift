//
//  TableViewCell.swift
//  StarWarsRx
//
//  Created by Pepdevils on 2/13/18.
//  Copyright © 2018 Pepdevils. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell{
    
    @IBOutlet weak var lbname: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
