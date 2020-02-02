//
//  FavoritesCell.swift
//  WeatherApp
//
//  Created by Amy Alsaydi on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit

class FavoriteCell: UICollectionViewCell {
    private lazy var cityImage: UIImageView = {
        let image = UIImageView()
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
        addSubview(cityImage)
        cityImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityImage.topAnchor.constraint(equalTo: topAnchor),
            cityImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            cityImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            cityImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    
    
    public func configureCell(photo: Photo) {
        
        cityImage.getImage(with: photo.largeImageURL) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print(appError)
//                DispatchQueue.main.async {
// mayve display a default image?
//                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.cityImage.image = image
                }
            }
        }
        
    }
}


