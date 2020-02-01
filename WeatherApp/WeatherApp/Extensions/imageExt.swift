//
//  imageExt.swift
//  WeatherApp
//
//  Created by Amy Alsaydi on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import NetworkHelper


extension UIImageView {
  func getImage(with urlString: String,
                completion: @escaping (Result<UIImage, AppError>) -> ()) {
    
//    let activityIndicator = UIActivityIndicatorView(style: .large)
//    activityIndicator.color = .black
//    activityIndicator.startAnimating()
//    activityIndicator.center = center
//    addSubview(activityIndicator)
    guard let url = URL(string: urlString) else {
      completion(.failure(.badURL(urlString)))
      return
    }
    
    let request = URLRequest(url: url)
    
    NetworkHelper.shared.performDataTask(with: request) { (result) in
//      DispatchQueue.main.async {
//        activityIndicator?.stopAnimating()
//      }
      switch result {
      case .failure(let appError):
        completion(.failure(.networkClientError(appError)))
      case .success(let data):
        if let image = UIImage(data: data) {
          completion(.success(image))
        }
      }
    }
  }
}
