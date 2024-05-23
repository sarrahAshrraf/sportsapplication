//
//  LatestEventsCell.swift
//  SportssApp
//
//  Created by sarrah ashraf on 23/05/2024.
//

import UIKit
import Kingfisher
class LatestEventsCell: UICollectionViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var awayTeamImg: UIImageView!
    
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var hoemteamImgg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with event: Event) {
//        scoreLabel.text = event.finalResult
        if event.finalResult == "-" {
                    scoreLabel.text = "N/A"
                } else {
                    scoreLabel.text = event.finalResult
                }
        dateLabel.text = event.eventTime
        timeLabel.text = event.eventDay
        
//        roundLabel.text = event.leagueRound
        homeTeamName.text = event.eventHomeTeam
        awayTeamName.text = event.eventAwayTeam
        hoemteamImgg.kf.setImage(with: URL(string: event.homeTeamLogo ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/EA_Sports_monochrome_logo.svg/2048px-EA_Sports_monochrome_logo.svg.png"))
        awayTeamImg.kf.setImage(with: URL(string: event.awayTeamLogo ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/EA_Sports_monochrome_logo.svg/2048px-EA_Sports_monochrome_logo.svg.png"))
    }

}
