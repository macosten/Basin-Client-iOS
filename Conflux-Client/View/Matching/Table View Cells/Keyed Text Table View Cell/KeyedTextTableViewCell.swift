//
//  KeyedTextTableViewCell.swift
//  Conflux-Client
//
//  Created by Zaccari Silverman on 7/5/19.
//  Copyright © 2019 macosten. All rights reserved.
//

import UIKit



class KeyedTextTableViewCell: UITableViewCell {
    

    
    //Not sure if we're going to separate these into two labels or not
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
