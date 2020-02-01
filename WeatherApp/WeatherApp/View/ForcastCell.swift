//
//  ForcastCell.swift
//  WeatherApp
//
//  Created by Amy Alsaydi on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class ForcastCell: UICollectionViewCell {
    
    // create variables
    // configure cell
    // constrain
    
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date Goes here"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var imageIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "cloud.sun")
        return image
    }()
    
    private lazy var lowTemp: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var highTemp: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupDateConstaints()
        setupIconConstraints()
        
    }
    
    public func configureCell(dayWeather: DailyForecast) {
        
        imageIcon.image = UIImage(named: dayWeather.icon)
        
        
        
    }
    
    private func setupDateConstaints(){
        addSubview(dateLabel)
                
        dateLabel.translatesAutoresizingMaskIntoConstraints = false // automatically happens in story board
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor)])
    }
    
    private func setupIconConstraints() {
        addSubview(imageIcon)
        
        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageIcon.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            imageIcon.centerXAnchor.constraint(equalTo: centerXAnchor), // center image 
            imageIcon.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            imageIcon.heightAnchor.constraint(equalTo: imageIcon.widthAnchor) // to make it a square
        ])
    }
    
    
}
