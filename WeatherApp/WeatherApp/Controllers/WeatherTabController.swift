//
//  WeatherTabController.swift
//  WeatherApp
//
//  Created by Amy Alsaydi on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class WeatherTabController: UITabBarController {
    
    private lazy var forcastVC: ForcastController = {
        let vc = ForcastController()
        vc.tabBarItem = UITabBarItem(title: "Weather", image: UIImage(systemName: "cloud.sun"), tag: 0)
        return vc
    }()
    
    private lazy var favVC: FavoritesController = {
        let vc = FavoritesController()
        vc.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), tag: 0)
        return vc
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let controllers  = [forcastVC, favVC]
        viewControllers = controllers.map { UINavigationController(rootViewController: $0)}

        // Do any additional setup after loading the view.
    }
    


}
