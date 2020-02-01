//
//  DetailController.swift
//  WeatherApp
//
//  Created by Amy Alsaydi on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit

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
        
        guard let weather = weather, let photo = photo else {
            fatalError("couldnt get weather or photo from other VC check segue")
        }
        
        highTempLabel.text = weather.temperatureHigh.description
        
        cityImageView.getImage(with: photo.largeImageURL) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                // show default
                print(appError)
            case .success(let image):
                DispatchQueue.main.async {
                    self?.cityImageView.image = image
                }
            }
        }
        
    }

}
