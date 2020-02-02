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
            DispatchQueue.main.async {
                self.favView.collectionView.reloadData()
            }
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
        favView.collectionView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadfavorties()
    }
    
    
    private func loadfavorties() {
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
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = favView.collectionView.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as? FavoriteCell else {
            fatalError("could not downcast fav cell")
        }
        let favPic = favorites[indexPath.row]
        cell.configureCell(photo: favPic)
        return cell
    }
    
    
}

extension FavoritesController: UICollectionViewDelegateFlowLayout {

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    // expecting a cg size which is a tuple of two values
    
    let interItemSpacing: CGFloat = 10 // space betweem items
    let maxWidth = UIScreen.main.bounds.size.width // device width
    
    let numberOfItems: CGFloat = 2 // items
    let totalSpacing: CGFloat = numberOfItems * interItemSpacing
    
    let itemWidth: CGFloat = (maxWidth - totalSpacing)/numberOfItems
    
    return CGSize(width: itemWidth, height: itemWidth * 1.2)
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    // padding sround collectionview
    return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

}

}
