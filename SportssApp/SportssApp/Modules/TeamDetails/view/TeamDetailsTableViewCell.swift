//
//  TeamDetailsTableViewCell.swift
//  SportssApp
//
//  Created by Somia on 22/05/2024.
//

import UIKit

class TeamDetailsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var playerImg: UIImageView!
    
    @IBOutlet weak var playerNameLabl: UILabel!
    
    @IBOutlet weak var playerAgeLabel: UILabel!
    
    @IBOutlet weak var playerNumberLabel: UILabel!
    
    @IBOutlet weak var playerPositionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        playerImg.layer.cornerRadius = playerImg.frame.size.width / 2
            playerImg.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
