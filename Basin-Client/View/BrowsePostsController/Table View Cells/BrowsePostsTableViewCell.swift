//
//  BrowsePostsTableViewCell.swift
//  Basin-Client
//
//  Created by Zaccari Silverman on 12/23/19.
//  Copyright © 2019 macosten. All rights reserved.
//

import UIKit

class BrowsePostsTableViewCell: UITableViewCell {

    @IBOutlet weak var postTitleLabel: UILabel!
    
    @IBOutlet weak var postUsernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
