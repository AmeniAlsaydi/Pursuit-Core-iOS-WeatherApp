//
//  FavoritesView.swift
//  WeatherApp
//
//  Created by Amy Alsaydi on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavoritesView: UIView {

    public lazy var collectionView: UICollectionView = {
        // lazy, we want to instantiate it when its called
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout) // like creating an empty variable
        cv.backgroundColor = .blue
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
        setupCVContraints()
    }
    
    private func setupCVContraints() {
        addSubview(collectionView)
                
        collectionView.translatesAutoresizingMaskIntoConstraints = false // automatically happens in story board
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }

}
