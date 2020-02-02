//
//  FavoritesController.swift
//  WeatherApp
//
//  Created by Amy Alsaydi on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence

class FavoritesController: UIViewController {
    
    private var favView = FavoritesView()
    

    private var favorites = [Photo]() {
        didSet {
            // reload collection view
        }
    }
    
    private let dataPersistance = DataPersistence<Photo>(filename: "favPhotos.plist")
    
    override func loadView() {
        view = favView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Favorites"

        view.backgroundColor = .white
        favView.collectionView.dataSource = self
        favView.collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: "favCell")
        // favView.collectionView.delegate = self
        loadfavorties()
    }
    
    
    func loadfavorties() {
        do {
            favorites = try dataPersistance.loadItems()
            //print(favorites.count)
        } catch {
            print("error retreiving photos: \(error)")
        }
        
    }
}

extension FavoritesController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = favView.collectionView.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as? FavoriteCell else {
            fatalError("could not downcast fav cell")
        }
        cell.backgroundColor = .blue
        return cell
    }
    
    
}
