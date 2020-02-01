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
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.thin)
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
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.thin)
        return label
    }()
    
    private lazy var highTemp: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.thin)
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
        setuplowLabelConstraints()
        setuphighLabelConstraints()
        
    }
    
    public func configureCell(dayWeather: DailyForecast) {
        
        imageIcon.image = UIImage(named: dayWeather.icon)
        dateLabel.text = Double(dayWeather.time).convertTime()
        highTemp.text = dayWeather.temperatureHigh.description
        lowTemp.text = dayWeather.temperatureLow.description
 
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
            imageIcon.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            imageIcon.heightAnchor.constraint(equalTo: imageIcon.widthAnchor) // to make it a square
        ])
    }
    
    private func setuplowLabelConstraints() {
        addSubview(highTemp)
        highTemp.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            highTemp.topAnchor.constraint(equalTo: imageIcon.bottomAnchor, constant: 5),
            highTemp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            highTemp.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5)
            
        ])
        
    }
    
    private func setuphighLabelConstraints() {
        addSubview(lowTemp)
        lowTemp.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lowTemp.topAnchor.constraint(equalTo: highTemp.bottomAnchor, constant: 5),
            lowTemp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            lowTemp.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5)
            
        ])
        
    }
    
}


extension Double {
    func convertTime() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
}
