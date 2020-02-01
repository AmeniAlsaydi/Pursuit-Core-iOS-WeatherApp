//
//  LocationExt.swift
//  WeatherApp
//
//  Created by Amy Alsaydi on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import MapKit

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
