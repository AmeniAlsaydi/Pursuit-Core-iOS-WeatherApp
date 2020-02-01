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
    
    public lazy var cityImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(systemName: "cloud.sun")
        return image
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
        setUpcityImageConstraints()
        
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
    
    private func setUpcityImageConstraints() {
        addSubview(cityImage)
        cityImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            //cityImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            //cityImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cityImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.60),
            cityImage.heightAnchor.constraint(equalTo: cityImage.widthAnchor),
            cityImage.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        // TODO: Fix image constraints
        
    }
    
}
