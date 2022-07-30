//
//  FeedCell.swift
//  InstaCloneFirebase
//
//  Created by Macbook Pro on 29.07.2022.
//

import UIKit

class FeedCell: UITableViewCell {
   
    @IBOutlet weak var useremailLabel: UILabel!
    @IBOutlet weak var userimageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func likeButtonClicked(_ sender: Any) {
    
        if likeButton.tag == 0 {
            likeButton.setImage(UIImage(named: "like_full"), for: .normal)
            likeButton.tag = 1
        }
        else {
            likeButton.setImage(UIImage(named: "like_empty"), for: .normal)
            likeButton.tag = 0
        }
      
    }
    
}
