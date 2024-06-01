//
//  LeagueDetailsViewController.swift
//  SportssApp
//
//  Created by sarrah ashraf on 22/05/2024.
//

import UIKit

class LeagueDetailsViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var favoriteBtn: UIBarButtonItem!
    @IBAction func favoriteButton(_ sender: UIBarButtonItem) {
        favoriteButtonTapped()
        NotificationCenter.default.post(name: NSNotification.Name("FavoriteUpdated"), object: nil)

    }
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
  
    }
    
    var indicator: UIActivityIndicatorView!
    var sportName:String = ""
    var leagueId:Int = 0
    var leagueName:String = ""
    var leagueImage:String = ""
    var dataFetchedCounter = 0
    var viewModel: LeagueDetailsViewModel!
    @IBOutlet weak var leaguesCollectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.hidesBackButton = true
        
        self.title = "\(leagueName)"
        
        viewModel.bindDBToViewController = { [weak self] in
                   self?.updateFavoriteButton()
               }

        indicator = UIActivityIndicatorView(style: .large)
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        if viewModel.resultUpComingEvents?.isEmpty ?? true {
                indicator.startAnimating()
            } else {
                indicator.stopAnimating()
            }
    }


    func favoriteButtonTapped() {
        if viewModel.isFav {
            viewModel.deleteLeagueFromDB(leagueId: leagueId)
        } else {
            viewModel.saveLeagueToDB(leagueId: leagueId, leagueName: leagueName, leagueImg: leagueImage, sportName: sportName)
        }
        updateFavoriteButton()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        leaguesCollectionView.dataSource = self
        guard let collectionView = leaguesCollectionView else {
            return
        }
        collectionView.dataSource = self

        leaguesCollectionView.delegate = self
        let eventCell = UINib(nibName: "UpComingEventsCell", bundle: nil)
        leaguesCollectionView.register(eventCell, forCellWithReuseIdentifier: "UpComingEventsCell")
        
        let latestEventCell = UINib(nibName: "LatestEventsCell", bundle: nil)
        leaguesCollectionView.register(latestEventCell, forCellWithReuseIdentifier: "LatestEventsCell")
        
        let teamCell = UINib(nibName: "TeamCell", bundle: nil)
        leaguesCollectionView.register(teamCell, forCellWithReuseIdentifier: "TeamCell")
        let headerNib = UINib(nibName: "HeaderCell", bundle: nil)
            leaguesCollectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCell")
           
        viewModel = LeagueDetailsViewModel()
        
        viewModel.bindDBToViewController = { [weak self] in
                   self?.updateFavoriteButton()
               }
        viewModel.isFavLeague(leagueId: leagueId)

        
        fetchNetworkData()
        setUpUI()
        saveToDB()
    }
    
    func updateFavoriteButton() {
        
            let buttonImage = viewModel.isFav ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        favoriteBtn.image = buttonImage
        }
    
    func fetchNetworkData(){
        switch sportName {
           case "football":
            viewModel.fetchUpComingEvents(sportName: sportName, leagueID: "\(String(leagueId))", startDate: Utilities.calculateCurrentDate(), endDate: Utilities.calculateEndDate(), eventType: .upcoming)
            viewModel.fetchLatestEvents(sportName: sportName, leagueID: "\(String(leagueId))", startDate: Utilities.calculateStartDate(), endDate: Utilities.calculateCurrentDate(), eventType: .latest)
            viewModel.fetchTeamData( leagueID:"\(leagueId)", sportName: sportName)

           case "tennis":
            viewModel.fetchTennisUpComingEvents(sportName: sportName, leagueID: "\(String(leagueId))", startDate: Utilities.calculateCurrentDate(), endDate: Utilities.calculateEndDate(), eventType: .upcoming)
            viewModel.fetchLatestEvents(sportName: sportName, leagueID: "\(String(leagueId))", startDate: Utilities.calculateStartDate(), endDate: Utilities.calculateCurrentDate(), eventType: .latest)

            viewModel.fetchTennisPlayersData( leagueID:"\(leagueId)", sportName: sportName)

            
           default:
               print("Unsupported sport: \(sportName)")
               return
           }
        print("===================ID ")
        print("\(String(leagueId))")

        
        print (sportName)
        print (leagueId)

        
    }

    func setUpUI(){
        viewModel.bindResultToViewController = { [weak self] in
        self?.dataFetchedCounter += 1

        DispatchQueue.main.async {
  //          self?.testLabel.text = self?.viewModel.resultUpComingEvents![0].eventAwayTeam
          if(self!.dataFetchedCounter % 3 == 0){
              print ("inside if")
            self?.indicator.stopAnimating()
            self?.leaguesCollectionView.reloadData()
            let layout = UICollectionViewCompositionalLayout{
              index, environment in
              if self?.viewModel.resultUpComingEvents?.count ?? 0 == 0{
                switch index{
                case 0:
                  return self?.drawTheVerticalSection()
                default:
                  return self?.drawTheBottomHorizontalSection()
                }
              }else{
                  print ("inside else")

                switch index{
                case 0:

                  return self?.drawTheHorizontalSection()
                case 1:
                  return self?.drawTheVerticalSection()
                default:
                  return self?.drawTheBottomHorizontalSection()
                }
              }
            }
            self?.leaguesCollectionView.setCollectionViewLayout(layout, animated: true)
          }
        }
      }
    }
    

    
    
    func saveToDB(){}
    
//UI
    func drawTheHorizontalSection() -> NSCollectionLayoutSection{
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(232))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .groupPagingCentered
      section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 16, trailing: 8)
      section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
      return section
    }

    func drawTheVerticalSection() -> NSCollectionLayoutSection{
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(232))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0)
      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 8, trailing: 12)

      section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
      return section
    }

    func drawTheBottomHorizontalSection() -> NSCollectionLayoutSection{
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(132), heightDimension: .absolute(158))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .continuous
      section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 16, trailing: 0)
      section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
      return section
    }


}


extension LeagueDetailsViewController{

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    var sectionCounter = 3

    if viewModel.resultUpComingEvents?.count ?? 0 == 0{
      sectionCounter -= 1
    }


    return sectionCounter
  }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           guard kind == UICollectionView.elementKindSectionHeader else {
               fatalError("error in header")
           }
           
           let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
           
           if viewModel.resultUpComingEvents?.count ?? 0 == 0 {
               switch indexPath.section {
               case 0:
                   headerView.headerTitle.text = "Latest Events"
               default:
                   if sportName == "tennis" {
                       headerView.headerTitle.text = "Players"
                   } else {
                       headerView.headerTitle.text = "Teams"
                   }               }
           } else {
               switch indexPath.section {
               case 0:
                   headerView.headerTitle.text = "Upcoming Events"
               case 1:
                   headerView.headerTitle.text = "Latest Events"
               default:
                   
                   if sportName == "tennis" {
                       headerView.headerTitle.text = "Players"
                   } else {
                       headerView.headerTitle.text = "Teams"
                   }
                   
               }
           }
           
           return headerView
       }
       

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if viewModel.resultUpComingEvents?.count ?? 0 == 0 {
                switch section {
                case 0:
                    return viewModel.latestEventResult?.count ?? 0
                default:
                    if sportName == "tennis" {
                        return viewModel.players?.count ?? 0
                    } else {
                        return viewModel.teams?.count ?? 0
                    }
                }
            } else {
                switch section {
                case 0:
                    return viewModel.resultUpComingEvents?.count ?? 0
                case 1:
                    return viewModel.latestEventResult?.count ?? 0
                default:
                    if sportName == "tennis" {
                        return viewModel.players?.count ?? 0
                    } else {
                        return viewModel.teams?.count ?? 0
                    }
                }
            }
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpComingEventsCell", for: indexPath) as! UpComingEventsCell
            let latestEventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestEventsCell", for: indexPath) as! LatestEventsCell
            let teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! TeamCell

            makeCellBorderRadius(cell: eventCell)
            makeCellBorderRadius(cell: latestEventCell)
            makeCellBorderRadius(cell: teamCell)

            if viewModel.resultUpComingEvents?.count ?? 0 == 0 {
                switch indexPath.section {
                case 0:
                    latestEventCell.configure(with: (viewModel.latestEventResult?[indexPath.row])!)
                    return latestEventCell
                default:
                    if sportName == "tennis" {
                        teamCell.configure(with: (viewModel.players?[indexPath.row])!)
                    } else {
                        teamCell.configure(with: (viewModel.teams?[indexPath.row])!)
                    }
                    return teamCell
                }
            } else {
                switch indexPath.section {
                case 0:
                    eventCell.configure(with: (viewModel.resultUpComingEvents?[indexPath.row])!)
                    return eventCell
                case 1:
                    latestEventCell.configure(with: (viewModel.latestEventResult?[indexPath.row])!)
                    return latestEventCell
                default:
                    if sportName == "tennis" {
                        print("inside tennis if")
                        teamCell.configure(with: (viewModel.players?[indexPath.row])!)
                    } else {
                        teamCell.configure(with: (viewModel.teams?[indexPath.row])!)
                    }
                    return teamCell
                }
            }
        }
    

  func makeCellBorderRadius(cell: UICollectionViewCell){
    cell.contentView.backgroundColor = .white
    cell.contentView.layer.borderWidth = 0.5
    cell.contentView.layer.borderColor = UIColor.systemGray2.cgColor
    cell.contentView.layer.cornerRadius = 16
  }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let upcomingEventsCount = viewModel.resultUpComingEvents?.count ?? 0
        if (upcomingEventsCount == 0 && indexPath.section == 1) || (upcomingEventsCount != 0 && indexPath.section == 2) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let teamVC = storyboard.instantiateViewController(identifier: "TeamVC") as? TeamDetailsViewController else {
                return
            }
            teamVC.sportName = sportName
            
            if sportName == "football" {
                if let teamKey = viewModel.teams?[indexPath.row].team_key {
                    teamVC.teamId = teamKey
                }
            } else if sportName == "tennis" {
                if let playerID = viewModel.players?[indexPath.row].player_key {
                    teamVC.playerID = playerID
                }
            }
            
            present(teamVC, animated: true, completion: nil)
        }
    }

    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//      let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpComingEventsCell", for: indexPath) as! UpComingEventsCell
//        let latestEventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestEventsCell", for: indexPath) as! LatestEventsCell
//      let teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! TeamCell
//
//      makeCellBorderRadius(cell: eventCell)
//        makeCellBorderRadius(cell: latestEventCell)
//      makeCellBorderRadius(cell: teamCell)
//
//      if viewModel.resultUpComingEvents?.count ?? 0 == 0{
//        switch indexPath.section {
//        case 0:
//          latestEventCell.configure(with:  (viewModel.latestEventResult?[indexPath.row])!)
//          return latestEventCell
//        default:
//          teamCell.configure(with:  (viewModel.teams?[indexPath.row])!)
//          return teamCell
//        }
//      } else {
//        switch indexPath.section {
//        case 0:
//          eventCell.configure(with: (viewModel.resultUpComingEvents?[indexPath.row])!)
//          return eventCell
//        case 1:
//            latestEventCell.configure(with:  (viewModel.latestEventResult?[indexPath.row])!)
//          return latestEventCell
//        default:
//          teamCell.configure(with: (viewModel.teams?[indexPath.row])!)
//          return teamCell
//        }
//      }
//    }



  }
