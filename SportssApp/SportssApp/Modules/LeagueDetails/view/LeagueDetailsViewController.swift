//
//  LeagueDetailsViewController.swift
//  SportssApp
//
//  Created by sarrah ashraf on 22/05/2024.
//

import UIKit

class LeagueDetailsViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {
    var indicator: UIActivityIndicatorView!
    var sportName:String = ""
    var leagueId:Int = 0
    var leagueName:String = ""
    var leagueImage:String = ""
    var dataFetchedCounter = 0
    var viewModel: LeagueDetailsViewModel!
    @IBOutlet weak var leaguesCollectionView: UICollectionView!
//    @IBAction func backButton(_ sender: UIBarButtonItem) {
//    }
//    @IBAction func favoriteBtn(_ sender: UIButton) {
//        viewModel.saveLeagueToDB(leagueId: leagueId, leagueName: leagueName, leagueImg: leagueImage, sportName: sportName)
//        print("button clickedxxxxxxxxxxxxxx")
//        
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.hidesBackButton = true
        
        self.title = "League Details"
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.rightBarButtonItem = favoriteButton
        
        indicator = UIActivityIndicatorView(style: .large)
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    // Favorite button action
    @objc func favoriteButtonTapped() {
print("TAAApppppppepdkjdhgy78290-=1===1=1=1==1=1=")    }

    override func viewDidLoad() {
        super.viewDidLoad()
        leaguesCollectionView.dataSource = self
        leaguesCollectionView.delegate = self
        let eventCell = UINib(nibName: "UpComingEventsCell", bundle: nil)
        leaguesCollectionView.register(eventCell, forCellWithReuseIdentifier: "UpComingEventsCell")
        let teamCell = UINib(nibName: "TeamCell", bundle: nil)
        leaguesCollectionView.register(teamCell, forCellWithReuseIdentifier: "TeamCell")
        let headerNib = UINib(nibName: "HeaderCell", bundle: nil)
            leaguesCollectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCell")
           
        viewModel = LeagueDetailsViewModel()
        
        fetchNetworkData()
        setUpUI()
        saveToDB()
    }
    
    func fetchNetworkData(){
        
        viewModel.fetchUpComingEvents(sportName: sportName, leagueID: "\(String(leagueId))", startDate: "2024-01-18", endDate: "2025-01-18", eventType: .upcoming)
        
        print (sportName)
        print (leagueId)

  //    viewModel.getUpcomingEvent(sportName: sportName, leagueId: "\(leagueId)", startDate: Constants.previousYear, endDate: Constants.currentDate, eventType: .latest)

        viewModel.fetchTeamData( leagueID:"\(leagueId)", sportName: sportName)
        
    }
    func setUpUI(){
        viewModel.bindResultToViewController = { [weak self] in
        self?.dataFetchedCounter += 1

        DispatchQueue.main.async {
  //          self?.testLabel.text = self?.viewModel.resultUpComingEvents![0].eventAwayTeam
          if(self!.dataFetchedCounter % 1 == 0){
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
                   headerView.headerTitle.text = "Upcoming Events"
               default:
                   headerView.headerTitle.text = "Teams"
               }
           } else {
               switch indexPath.section {
               case 0:
                   headerView.headerTitle.text = "Upcoming Events"
               case 1:
                   headerView.headerTitle.text = "Latest Events"
               default:
                   headerView.headerTitle.text = "Teams"
               }
           }
           
           return headerView
       }
       

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    if viewModel.resultUpComingEvents?.count ?? 0 == 0{
      switch section{
      case 0:
        return viewModel.resultUpComingEvents?.count ?? 0
      default:
        return viewModel.teams?.count ?? 0
      }
    } else {
      switch section{
      case 0:
        return viewModel.resultUpComingEvents?.count ?? 0
      case 1:
        return viewModel.resultUpComingEvents?.count ?? 0
      default:
        return viewModel.teams?.count ?? 0
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
        guard let upcomingEventsCount = viewModel.resultUpComingEvents?.count else { return }
        
        if (upcomingEventsCount == 0 && indexPath.section == 1) || (upcomingEventsCount != 0 && indexPath.section == 2) {
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let teamVC = storyboard.instantiateViewController(identifier: "TeamVC") as? TeamDetailsViewController else {
                return
            }
            
            teamVC.sportName = sportName
            
            if let teamKey = viewModel.teams?[indexPath.row].team_key {
                teamVC.teamId = teamKey
                navigationController?.pushViewController(teamVC, animated: true)
            }
        }
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpComingEventsCell", for: indexPath) as! UpComingEventsCell
      let teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! TeamCell

      makeCellBorderRadius(cell: eventCell)
      makeCellBorderRadius(cell: teamCell)

      if viewModel.resultUpComingEvents?.count ?? 0 == 0{
        switch indexPath.section {
        case 0:
//            eventCell.configure(with: viewModel.resultUpComingEvents?[indexPath.row]!))
            eventCell.configure(with: viewModel.resultUpComingEvents![indexPath.row])
          return eventCell
        default:
            teamCell.configure(with: viewModel.teams![indexPath.row])
          return teamCell
        }
      } else {
        switch indexPath.section {
        case 0:
            eventCell.configure(with: viewModel.resultUpComingEvents![indexPath.row])
          return eventCell
        case 1:
            eventCell.configure(with: viewModel.resultUpComingEvents![indexPath.row])
          return eventCell
        default:
            teamCell.configure(with: viewModel.teams![indexPath.row])
          return teamCell
        }
      }
    }

  }
