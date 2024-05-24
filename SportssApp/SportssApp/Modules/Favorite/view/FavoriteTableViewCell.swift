//
//  FavoriteTableViewCell.swift
//  SportssApp
//
//  Created by Somia on 24/05/2024.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    
    @IBOutlet weak var favoriteimg: UIImageView!
    
    @IBOutlet weak var favoriteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        favoriteimg.layer.cornerRadius = favoriteimg.frame.size.width / 2
        favoriteimg.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
