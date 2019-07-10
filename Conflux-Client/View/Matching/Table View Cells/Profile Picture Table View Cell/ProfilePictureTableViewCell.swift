//
//  ProfilePictureTableViewCell.swift
//  Conflux-Client
//
//  Created by Zaccari Silverman on 7/5/19.
//  Copyright © 2019 macosten. All rights reserved.
//

import UIKit

class ProfilePictureTableViewCell: UITableViewCell {

    @IBOutlet weak var coverPhotoImageView: UIImageView!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
