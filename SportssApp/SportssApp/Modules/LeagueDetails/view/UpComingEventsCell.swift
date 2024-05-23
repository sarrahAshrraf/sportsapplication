//
//  UpComingEventsCell.swift
//  SportssApp
//
//  Created by sarrah ashraf on 22/05/2024.
//

import UIKit
import Kingfisher
class UpComingEventsCell: UICollectionViewCell {
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var awayTeamImg: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var homeTeamImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(with event: Event) {
        scoreLabel.text = event.finalResult
        if let leagueName = event.leagueName {
            self.leagueName.text = leagueName
           } else {
               leagueName.text = "Unknown League"
           }
        roundLabel.text = event.leagueRound
        homeTeamName.text = event.eventHomeTeam
        awayTeamName.text = event.eventAwayTeam
        homeTeamImg.kf.setImage(with: URL(string: event.homeTeamLogo ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/EA_Sports_monochrome_logo.svg/2048px-EA_Sports_monochrome_logo.svg.png"))
        awayTeamImg.kf.setImage(with: URL(string: event.awayTeamLogo ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/EA_Sports_monochrome_logo.svg/2048px-EA_Sports_monochrome_logo.svg.png"))
    }

}
