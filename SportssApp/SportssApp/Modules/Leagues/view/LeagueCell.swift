//
//  LeagueCell.swift
//  SportssApp
//
//  Created by sarrah ashraf on 22/05/2024.
//

import UIKit

class LeagueCell: UITableViewCell {

    @IBOutlet weak var leagueImg: UIImageView!
    @IBOutlet weak var leagueLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
