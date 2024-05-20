//
//  FavoriteTableViewCell.swift
//  SportssApp
//
//  Created by Somia on 20/05/2024.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {


    @IBOutlet weak var myFavImg: UIImageView!
    
    @IBOutlet weak var myFavLabel: UILabel!
    
    override func awakeFromNib() {       
        super.awakeFromNib()
        
        self.myFavImg.layer.cornerRadius = myFavImg.frame.size.width / 2
        myFavImg.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
