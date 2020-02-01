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
    
    
    @IBOutlet weak var citynameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var sumaryLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    public var photo: Photo?
    public var weather: DailyForecast?
    public var cityName: String?
    
    override func viewDidLayoutSubviews() {
        cityImageView.layer.cornerRadius = cityImageView.frame.width/2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    
    private func updateUI() {
        
        guard let weather = weather, let cityName = cityName else {
            fatalError("couldnt get weather or photo from other VC check segue")
        }
        // fix city label
        citynameLabel.text = cityName
        dateLabel.text = Double(weather.time).convertToDate(dateFormat: "EEEE, MMM d, yyyy")
        sumaryLabel.text = weather.summary
        
        highTempLabel.text = "\(weather.temperatureHigh) °F"
        
        lowTempLabel.text = "\(weather.temperatureLow) °F"
        windLabel.text = "\(weather.windSpeed) mph"
        rainLabel.text = "\(weather.precipProbability)%"
        sunsetLabel.text = Double(weather.sunsetTime).convertTime()
        sunriseLabel.text = Double(weather.sunriseTime).convertTime()
        
        cityImageView.getImage(with: photo!.largeImageURL) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.cityImageView.image = UIImage(named: "world")
                }
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
