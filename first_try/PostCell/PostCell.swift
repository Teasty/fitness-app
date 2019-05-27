//
//  PostCell.swift
//  first_try
//
//  Created by Андрей Лихачев on 26/05/2019.
//  Copyright © 2019 Андрей Лихачев. All rights reserved.
//

import UIKit

class PostCell: UICollectionViewCell {

    
    @IBOutlet weak var PostTitleLabel: UILabel!
    @IBOutlet weak var PostShortDescLabel: UILabel!
    
    var post : Post? {
        
        didSet{
            self.updateUI()
        }
    }
    
    func updateUI(){
        if let post = post{
            PostTitleLabel.text = post.post_title
            PostShortDescLabel.text = post.post_short_desc
        } else {
            PostTitleLabel.text = nil
            PostShortDescLabel.text = nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
