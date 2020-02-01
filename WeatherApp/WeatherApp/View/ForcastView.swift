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
        cv.backgroundColor = .purple
        return cv
        
        
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
        setupCollectionViewConstraints()
        
    }
    
    func setupCollectionViewConstraints() {
        addSubview(collectionView)
                
        collectionView.translatesAutoresizingMaskIntoConstraints = false // automatically happens in story board
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
                                             
        ])
    }
    
}
