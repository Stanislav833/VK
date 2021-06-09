//
//  AuthorDataTableViewCell.swift
//  Weather
//
//  Created by Stanislav Vasilev on 06.06.2021.
//

class AuthorDateTableViewCell: UITableViewCell {
   
    @IBOutlet weak var auther: UILabel!
    
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: LikeButton!
    @IBOutlet weak var commentButton: LikeButton!
    @IBOutlet weak var repostButton: LikeButton!
    @IBOutlet weak var viewButton: LikeButton!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
}

