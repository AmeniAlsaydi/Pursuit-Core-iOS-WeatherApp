//
//  DetailController.swift
//  WeatherApp
//
//  Created by Amy Alsaydi on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var highTempLabel: UILabel!
    
    public var photo: Photo?
    public var weather: DailyForecast?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    
    private func updateUI() {
        
        
        
    }

}
