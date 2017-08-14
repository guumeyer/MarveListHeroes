//
//  ImageViewTableViewCell.swift
//  MarvelHeros
//
//  Created by gustavo r meyer on 8/13/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit

class ImageViewTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
