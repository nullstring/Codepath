//
//  BusinessTableViewCell.swift
//  Yelp
//
//  Created by Harsh Mehta on 9/19/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var ratingsImageView: UIImageView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var numReviewsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var business: Business! {
        didSet {
            posterImageView.setImageWith(business.imageURL!)
            ratingsImageView.setImageWith(business.ratingImageURL!)
            businessNameLabel.text = business.name!
            numReviewsLabel.text =  "\(business.reviewCount!.intValue) Reviews"
            distanceLabel.text = business.distance
            categoriesLabel.text = business.categories
            addressLabel.text = business.address
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        posterImageView.layer.cornerRadius = 3
        posterImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
