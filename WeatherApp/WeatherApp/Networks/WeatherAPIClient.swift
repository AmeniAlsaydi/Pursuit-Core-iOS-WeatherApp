//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Amy Alsaydi on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import NetworkHelper


struct WeatherAPIClient {
    static func getWeatherInfo(lat: Double, long: Double, completion: @escaping (Result<Weather, AppError>)-> ()) {
    
        
        let endpoint = "https://api.darksky.net/forecast/\(SecretsKey.key)/\(lat),\(long)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        // make a request
        let request = URLRequest(url: url) // this is what is passed to URLSession in network helper
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            // result is either data or an error
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                 // use model to Parse data
                do {
                    let weatherData = try JSONDecoder().decode(Weather.self, from: data)
                    completion(.success(weatherData))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
    
    
}
