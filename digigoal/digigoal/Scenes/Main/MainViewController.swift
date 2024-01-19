//
//  MainViewController.swift
//  digigoal
//
//  Created by nattachai.nuplak on 18/1/2567 BE.
//

import Foundation
import UIKit
import Combine

class MainViewController: UITabBarController, UITabBarControllerDelegate {
    
    var cancellables = Set<AnyCancellable>()
    
    let tabOne: HomeViewController = {
        let tabOne = HomeViewController()
        tabOne.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        return tabOne
    }()
    
    let tabTwo: WalletViewController = {
        let tabTwo = WalletViewController()
        tabTwo.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "bag"), selectedImage: UIImage(systemName: "bag.fill"))
        return tabTwo
    }()
    
    let tabThree: AchievementViewController = {
        let tabThree = AchievementViewController()
        tabThree.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "star.circle"), selectedImage: UIImage(systemName: "star.circle.fill"))
        return tabThree
    }()
    
    
    let tabFour: ProfileViewController = {
        let tabFour = ProfileViewController()
        tabFour.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        return tabFour
    }()
    
    
    override func viewDidLoad() {
        setupView()
        
        SocketIOManager.shared.$newNotification.sink { [weak self] val in
            self?.tabFour.tabBarItem.badgeValue = val == 0 ? nil : "\(String(describing: val))"
        }.store(in: &cancellables)
    }
    
    private func setupView() {
        self.delegate = self
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = #colorLiteral(red: 0.7889479399, green: 0.3668174744, blue: 0.2804781497, alpha: 1)
        self.tabBar.barTintColor = .white
        self.viewControllers = [tabOne, tabTwo, tabThree, tabFour]
    }
}
