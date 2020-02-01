//
//  ForcastController.swift
//  WeatherApp
//
//  Created by Amy Alsaydi on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import MapKit

class ForcastController: UIViewController {
    
    private var forcastView = ForcastView()
    public var cityPhotos = [Photo]()
    public var cityName = ""
    
    private var weeksForcast = [DailyForecast]() {
        didSet {
            DispatchQueue.main.async {
                self.forcastView.collectionView.reloadData()
            }
        }
    }
    
    
    private var zipCode = "11201" { // populate this from user defaults else "11201" want to get fancy add current location?
        didSet {
            getCityWeather(zipCode: zipCode)
        }
    }
    
    override func loadView() {
        view = forcastView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCityWeather(zipCode: zipCode)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Todays Weather"
        view.backgroundColor = .white
        
        forcastView.collectionView.register(ForcastCell.self, forCellWithReuseIdentifier: "forcastCell")
        forcastView.collectionView.dataSource = self
        forcastView.collectionView.delegate = self
        forcastView.zipCodeTextFeild.delegate = self 
    }
    
    private func getCityWeather(zipCode: String) {
        
        ZipCodeHelper.getLatLong(fromZipCode: zipCode) {  [weak self] (results) in
            switch results {
            case .success(let location):
                let lat = location.lat
                let long = location.long
                // use cordinates to get weather
                self?.getWeather(lat: lat, long: long)
            case .failure(let error):
                self?.showAlert(title: "Check Zipcode", message: "Hmm... we cant seem to find that zipcode, please try again")
                self?.forcastView.zipCodeTextFeild.text = ""
                print(error)
            }
        }
    }
    
    private func getWeather(lat: Double, long: Double) {
        WeatherAPIClient.getWeatherInfo(lat: lat, long: long) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let weather):
                self?.weeksForcast = weather.daily.data
                // print(weather.timezone) // repeatedly returns America/New_York no matter the zipcode ?
                
                let location = CLLocation(latitude: lat, longitude: long)
                location.fetchCityAndCountry { city, country, error in
                    guard let city = city, let country = country, error == nil else { return }
                    
                    self?.cityName = city
                    
                    DispatchQueue.main.async {
                        self?.forcastView.cityLabel.text = city + ", " + country
                        self?.forcastView.summaryLabel.text = weather.hourly.data[0].summary
                        let currentTemp = String(format: "%.0f", weather.hourly.data[0].temperature)
                        self?.forcastView.currentTempLabel.text = "\(currentTemp)°F"
                    }
                    self?.getCityPhotos(city: city)
                }
            }
        }
    }
    
    private func getCityPhotos(city: String) {
        PhotoApiClient.getPhotos(searchQuery: city) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("api client error: \(appError)")
            case .success(let photos):
                self?.cityPhotos = photos
            }
        }
    }
    
}


extension ForcastController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weeksForcast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // without downcasting to podcast cell, we wont have access propterties of the cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forcastCell", for: indexPath) as? ForcastCell else {
            fatalError("could not downcast podcast cell")
        }
        
        let weather = weeksForcast[indexPath.row]
        cell.configureCell(dayWeather: weather)
        
        cell.backgroundColor = .white
        return cell
    }
}

extension ForcastController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // expecting a cg size which is a tuple of two values
        
        let interItemSpacing: CGFloat = 10 // space betweem items
        let maxWidth = UIScreen.main.bounds.size.width // device width
        
        let numberOfItems: CGFloat = 2 // items
        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        
        let itemWidth: CGFloat = (maxWidth - totalSpacing)/numberOfItems
        
        return CGSize(width: itemWidth, height: itemWidth * 1.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // padding sround collectionview
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        // get instance of storyboard
        
        let detailStoryBoard = UIStoryboard(name: "WeatherDetail", bundle: nil) // name of the story board file
        
        guard let detailVC = detailStoryBoard.instantiateViewController(identifier: "DetailController") as? DetailController else {
            fatalError("could not downcast to DetailController")
        }
        
        // If no photos are returned
        if  cityPhotos.count != 0 {
            detailVC.photo = cityPhotos[indexPath.row]
        }
        
        detailVC.weather = weeksForcast[indexPath.row]
        detailVC.cityName = cityName 
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ForcastController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        guard let zipcode = textField.text else {
            getCityWeather(zipCode: zipCode)
            return true
        }
        zipCode = zipcode
        
        return true
    }
}



