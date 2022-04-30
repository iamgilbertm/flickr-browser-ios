//
//  PhotoCell.swift
//  FlickrBrowser
//
//  Created by Gilbert Mendoza on 4/30/22.
//

import AlamofireImage
import UIKit

class PhotoCell: UICollectionViewCell {
  @IBOutlet weak var imageView: UIImageView!
  
  func configure(with photo: Photo) {
    let activityIndicatorView = UIActivityIndicatorView()
    activityIndicatorView.center = CGPoint(x: frame.size.width  / 2, y: frame.size.height / 2)
    imageView.addSubview(activityIndicatorView)
    
    activityIndicatorView.startAnimating()
    
    imageView.setImageWithURL(photo.imageURL) {
      DispatchQueue.main.async {
        activityIndicatorView.stopAnimating()
      }
    }
  }
}
