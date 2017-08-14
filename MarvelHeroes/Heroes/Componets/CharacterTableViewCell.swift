//
//  CharacterTableViewCell.swift
//  MarvelHeros
//
//  Created by gustavo r meyer on 8/13/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    static let identifier = "CharacterTableViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    var character:Character?{
        didSet{
            
            guard let character = character else {return }
            
            if nameLabel != nil {
                nameLabel.text = "\(character.name!)"
            }
            self.thumbnailImageView.image = nil
            if let image = character.image {

                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                    return
                }
            }
            
            if let statusImageUrl = character.thumbnail?.getName() {
                URLSession.shared.dataTask(with: URL(string: statusImageUrl)!, completionHandler: { (data, request, error) in
                    
                    if error != nil {
                        return
                    }
                    
                    let image = UIImage(data: data!)
                    character.image = image
                    DispatchQueue.main.async {
                        self.thumbnailImageView.image = image
                    }
                }).resume()
            }

            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
