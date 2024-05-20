//
//  HomeCollectionViewCell.swift
//  SportssApp
//
//  Created by Somia on 20/05/2024.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var homeLabel: UILabel!
    
    @IBOutlet weak var homeSportsImg: UIImageView!
    func configue(with sport: Sport){
        homeSportsImg.image = UIImage(named: sport.sportImg)
        homeLabel.text = sport.sportName
    }
}
