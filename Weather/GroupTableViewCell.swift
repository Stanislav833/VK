//
//  GroupTableViewCell.swift
//  Weather
//
//  Created by Stanislav Vasilev on 08.03.2021.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLable: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLable.text = ""
    }
}
