//
//  ForcastView.swift
//  WeatherApp
//
//  Created by Amy Alsaydi on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class ForcastView: UIView {
    
    public lazy var collectionView: UICollectionView = {
        // lazy, we want to instantiate it when its called
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout) // like creating an empty variable
        cv.backgroundColor = .white
        return cv
    }()
    
    public lazy var todayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.light)
        label.text = "Today"
        return label
       }()
    
    public lazy var summaryLabel: UILabel = {
         let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.thin)
         label.text = "Summary goes here"
         return label
    }()
    
    public lazy var currentTempLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 100, weight: UIFont.Weight.ultraLight)
        return label
    }()
    
    public lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.light)
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var zipCodeTextFeild: UITextField = {
        let textfeild = UITextField()
        textfeild.textAlignment = .center
        textfeild.borderStyle = UITextField.BorderStyle.roundedRect
        textfeild.keyboardType = UIKeyboardType.numbersAndPunctuation
        textfeild.placeholder = "Search Zipcode"
        return textfeild
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
        setUpCityLabelConstraits()
        setupCollectionViewConstraints()
        setUpTextFeildConstraints()
        setuptodayLabelConstraints()
        setupSumarrayConstraints()
        setUpCurrentLablConstraints()
    }
    
    
    func setUpCityLabelConstraits() {
        addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
    }
    
    func setupCollectionViewConstraints() {
        addSubview(collectionView)
                
        collectionView.translatesAutoresizingMaskIntoConstraints = false // automatically happens in story board
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25)
        ])
    }
    
    private func setUpTextFeildConstraints() {
        addSubview(zipCodeTextFeild)
        
        zipCodeTextFeild.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            zipCodeTextFeild.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 5),
            zipCodeTextFeild.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            zipCodeTextFeild.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setuptodayLabelConstraints() {
        addSubview(todayLabel)
        todayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            todayLabel.topAnchor.constraint(equalTo: zipCodeTextFeild.bottomAnchor, constant: 30),
            todayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            todayLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setupSumarrayConstraints() {
        addSubview(summaryLabel)
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 20),
            summaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            summaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    public func setUpCurrentLablConstraints() {
        addSubview(currentTempLabel)
        currentTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        currentTempLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 20),
        currentTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor)])
        
    }
}
