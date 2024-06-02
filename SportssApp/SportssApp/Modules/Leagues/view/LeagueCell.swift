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
    var youtubeAction : ()->() = {}

    @IBAction func youTubBtn(_ sender: UIButton) {
        self.youtubeAction()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        leagueImg.layer.cornerRadius = leagueImg.frame.size.width / 2
               leagueImg.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
