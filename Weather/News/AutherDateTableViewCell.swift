//
//  AutherDateTableViewCell.swift
//  Weather
//
//  Created by Stanislav Vasilev on 06.06.2021.
//
import UIKit

class AutherDateTableViewCell: UITableViewCell {
   
    @IBOutlet weak var autherLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
}
