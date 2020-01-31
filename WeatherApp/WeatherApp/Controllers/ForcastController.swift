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
    
    private var zipCode = "11201" {
        didSet {
            // reload the collection view to display new city's weather
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue

        
        // getCity(zipCode: zipCode)
        
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


    }

  
}


extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
