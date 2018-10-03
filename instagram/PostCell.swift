//
//  PostCell.swift
//  instagram
//
//  Created by Francisco Hernanedez on 10/2/18.
//  Copyright © 2018 Francisco Hernanedz. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var PostImageView: UIImageView!
    @IBOutlet weak var CaptionUILable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
