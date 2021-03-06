//
//  MovieCell.swift
//  Flicks
//
//  Created by Harsh Mehta on 9/12/17.
//  Copyright © 2017 Harsh Mehta. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            self.backgroundColor = UIColor.blue
        } else {
            self.backgroundColor = UIColor.clear
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
            self.backgroundColor = UIColor.black
        } else {
            self.backgroundColor = UIColor.clear
        }
    }

}
