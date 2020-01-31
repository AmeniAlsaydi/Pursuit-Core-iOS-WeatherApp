//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    
    private var zipCode = "11201" {
        didSet {
            // reload the collection view to display new city's weather
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCity(zipCode: zipCode)
        
    }
    
    private func getCity(zipCode: String) {
        
        ZipCodeHelper.getLatLong(fromZipCode: zipCode) { (results) in
            switch results {
            case .success(let location):
                let lat = location.lat
                let long = location.long
                
                // use cordinates to get city
                let location = CLLocation(latitude: lat, longitude: long)
                location.fetchCityAndCountry { city, country, error in
                    guard let city = city, let country = country, error == nil else { return }
                    print(city + ", " + country)  // New York, United States
                       }
              
            case .failure(let error):
                print(error)
            }
        }
        
        // someone on stack over flow suggested using this api to get country info in json format from this api
        // https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=API_KEY

    }
    
    


}

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}

