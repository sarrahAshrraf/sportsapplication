//
//  TeamCell.swift
//  SportssApp
//
//  Created by sarrah ashraf on 22/05/2024.
//

import UIKit

class TeamCell: UICollectionViewCell {
    @IBOutlet weak var teamImg: UIImageView!
    
    @IBOutlet weak var teamName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(with team: Team) {
        teamName.text = team.team_name
        teamImg.kf.setImage(with: URL(string: team.team_logo ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/EA_Sports_monochrome_logo.svg/2048px-EA_Sports_monochrome_logo.svg.png"))
    }
    
    func configure(with player: TennisPlayer) {
        teamName.text = player.player_name
        print("======cel ")
        print(player.player_name)
        print(player.player_key)

        teamImg.image = UIImage(named: "player")
    }

}
