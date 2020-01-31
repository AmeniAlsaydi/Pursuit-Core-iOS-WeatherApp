//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Amy Alsaydi on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import XCTest

@testable import WeatherApp

class WeatherAppTests: XCTestCase {

    func testAPIClient() {
        
        // arrange
        let lat = 37.8267
        let long = -122.4233
        let expected = "America/Los_Angeles"
        let exp = XCTestExpectation(description: "rates found")
        
        //act
        
        WeatherAPIClient.getWeatherInfo(lat: lat, long: long) { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("appError: \(appError)")
            case .success(let weather):
                let timezone = weather.timezone
                
                 // assert
                
                XCTAssertEqual(timezone , expected)
                exp.fulfill()
            
            }
        }
        
        
        wait(for:[exp], timeout: 5.0)
        
    }

}
