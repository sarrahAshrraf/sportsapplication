//
//  ViewController.swift
//  SportssApp
//
//  Created by sarrah ashraf on 20/05/2024.
//

import UIKit

class ViewController: UIViewController , UICollisionBehaviorDelegate  {

    var ballImageView: UIImageView!
    var ballImages: [UIImage] = [UIImage(named: "football.jpg")!, UIImage(named: "baseball.jpeg")!, UIImage(named: "vollyball.jpg")!]
    var currentImageIndex = 0
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var itemBehavior: UIDynamicItemBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBallImageView()
        setupDynamicBehaviors()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.animateSpotifyWord()
        }
    }
    
    func setupBallImageView() {
        ballImageView = UIImageView(image: ballImages[currentImageIndex].resized(to: CGSize(width: 100, height: 100)))
        ballImageView.contentMode = .scaleAspectFill
        ballImageView.frame = CGRect(x: view.center.x - 50, y: 100, width: 100, height: 100)
        view.addSubview(ballImageView)
    }
    
    func setupDynamicBehaviors() {
        animator = UIDynamicAnimator(referenceView: view)
        
        gravity = UIGravityBehavior(items: [ballImageView])
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [ballImageView])
        collision.translatesReferenceBoundsIntoBoundary = true
        
        let bottomBoundary = CGPoint(x: 0, y: view.bounds.maxY)
        collision.addBoundary(withIdentifier: "bottomBoundary" as NSCopying, from: bottomBoundary, to: CGPoint(x: view.bounds.maxX, y: view.bounds.maxY))
        
        collision.collisionDelegate = self
        animator.addBehavior(collision)
        
        itemBehavior = UIDynamicItemBehavior(items: [ballImageView])
        itemBehavior.elasticity = 0.8
        animator.addBehavior(itemBehavior)
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        if let boundary = identifier as? String, boundary == "bottomBoundary" {
            changeBallImage()
        }
    }

    func changeBallImage() {
        currentImageIndex = (currentImageIndex + 1) % ballImages.count // Cycle through images
        ballImageView.image = ballImages[currentImageIndex].resized(to: CGSize(width: 100, height: 100))
    }
    
    func animateSpotifyWord() {
        let spotifyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        spotifyLabel.center = view.center
        spotifyLabel.textAlignment = .center
        spotifyLabel.text = "Spotify"
        spotifyLabel.font = UIFont.boldSystemFont(ofSize: 44)
        spotifyLabel.textColor = .black
        spotifyLabel.alpha = 0
        view.addSubview(spotifyLabel)
        
        UIView.animate(withDuration: 0.5, animations: {
            spotifyLabel.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 3, animations: {
                spotifyLabel.transform = CGAffineTransform(scaleX: 3, y: 3)
                spotifyLabel.alpha = 0
            }) { _ in
                spotifyLabel.removeFromSuperview()
                self.navigateToHomeViewController()
            }
        }
    }
    
//    func navigateToHomeViewController() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let aboutPageViewController = storyboard.instantiateViewController(withIdentifier: "homeID") as? SportsViewController {
//            aboutPageViewController.navigationItem.hidesBackButton = true
//            self.navigationController?.pushViewController(aboutPageViewController, animated: false)
//        }
//    }
    
    func navigateToHomeViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarID") as? UITabBarController {
            // Assuming you have the tab bar controller set as the initial view controller in the storyboard
            UIApplication.shared.windows.first?.rootViewController = tabBarController
        }
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

