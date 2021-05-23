//
//  PhotoCollectionViewCell.swift
//  Weather
//
//  Created by Stanislav Vasilev on 10.03.2021.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var photos: UIImageView!
    
  /*  var photos = [VKPhoto]() */
    override func prepareForReuse() {
        super.prepareForReuse()
        numberLabel.text = ""
    }
}
