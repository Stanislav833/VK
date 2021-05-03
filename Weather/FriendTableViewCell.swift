//
//  FriendTableViewCell.swift
//  Weather
//
//  Created by Stanislav Vasilev on 27.03.2021.
//

import UIKit

class FriendTableViewCell: UITableViewCell {


        @IBOutlet weak var titleLable: UILabel!
        @IBOutlet weak var icon: UIImageView!
        
        override func prepareForReuse() {
            super.prepareForReuse()
            titleLable.text = ""
        }
    }
