//
//  DetailController.swift
//  WeatherApp
//
//  Created by Amy Alsaydi on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit
import DataPersistence

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
    @IBOutlet weak var favoriteButton: UIButton!
    
    public var photo: Photo?
    public var weather: DailyForecast?
    public var cityName: String?
    public let dataPersistance = DataPersistence<Photo>(filename: "favPhotos.plist")
    
    
    override func viewDidLayoutSubviews() {
        cityImageView.layer.cornerRadius = cityImageView.frame.width/2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        checkPhoto()
    }
    
    private func checkPhoto() {
        
        // if nil disable button
        guard let photo = photo else {
            favoriteButton.isEnabled = false
            return
        }
        
        do {
            let favs = try dataPersistance.loadItems()
            if favs.contains(photo) {
                favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                favoriteButton.isEnabled = false 
            }
        } catch {
            print("error geting favs on detail vc")
        }
        
        // check if its already been faved, fill and disable button
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
        
        guard let photo = photo else {
            DispatchQueue.main.async {
                self.cityImageView.image = UIImage(named: "world")
            }
            return
        }
        
        cityImageView.getImage(with: photo.largeImageURL) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let image):
                DispatchQueue.main.async {
                    self?.cityImageView.image = image
                }
            }
        }
    }
    
    @IBAction func imageFavorited(_ sender: UIButton) {

        sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
        
        let url = FileManager.getPath(with: "favPhotos.plist", for: .documentsDirectory)
              print(url)
        
        guard let photo = photo else {
            return
        }
        
        showAlert(title: "City Image Favorited ⭐️", message: "Find all your favorite city images in your favorites tab!")
        
        do {
            try dataPersistance.createItem(photo)
        } catch {
            
            showAlert(title: "error saving photo", message: "\(error)")
        }
        
    }
    

}
