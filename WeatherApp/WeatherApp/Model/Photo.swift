//
//  Photo.swift
//  WeatherApp
//
//  Created by Amy Alsaydi on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation


struct PhotoSearch:Codable {
    let hits: [Photo]
}

struct Photo: Codable & Equatable{
    let largeImageURL: String
    let id: Int
    let user: String
    let likes: Int
    let favorites: Int
    let views: Int
    let tags: String
    let downloads: Int
}
