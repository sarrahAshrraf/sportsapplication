


//
//  SportsViewController.swift
//  SportssApp
//
//  Created by Somia on 20/05/2024.
//

import UIKit

class SportsViewController: UIViewController,UICollectionViewDelegate , UICollectionViewDataSource {

   
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    var viewModel: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        homeCollectionView.dataSource = self
              homeCollectionView.delegate = self
        homeCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.sports.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCollectionViewCell
        cell.configue(with: viewModel!.sports[indexPath.item])
//        cell.homeSportsImg.image = UIImage(named: images[indexPath.item])
//        cell.homeLabel.text = texts[indexPath.item]
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        return cell
    }
    
}

extension SportsViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (collectionView.bounds.width*0.45), height: (collectionView.bounds.width*0.85))
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 1, left: 10, bottom: 1, right: 10)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSport = viewModel!.sports[indexPath.item]
        
        let leaguesVC = AllLeaguesTableViewController()
        leaguesVC.sportName = selectedSport.sportName.lowercased()
        print(selectedSport.sportName)
        navigationController?.pushViewController(leaguesVC, animated: true)
    }
}




