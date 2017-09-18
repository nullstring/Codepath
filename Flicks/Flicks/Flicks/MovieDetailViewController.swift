//
//  MovieDetailViewController.swift
//  Flicks
//
//  Created by Harsh Mehta on 9/12/17.
//  Copyright © 2017 Harsh Mehta. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var movieInfoView: UIView!
    
    var movie: [String: Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set title.
        let title = movie["title"] as! String
        titleLabel.text = title
        
        // Set overview.
        let overview = movie["overview"] as! String
        overviewLabel.text = overview
        overviewLabel.sizeToFit()
        
        // For future reference, all possible sizes are here.
        // https://www.themoviedb.org/talk/53c11d4ec3a3684cf4006400?language=en
        let baseSmallImageUrl = "https://image.tmdb.org/t/p/w500"
        let baseLargeImageUrl = "https://image.tmdb.org/t/p/w1280"
        if let posterPath = movie["poster_path"] as? String {
            Helper.setImageWithURLRequest(imageView: posterView, smallImageUrl: baseSmallImageUrl+posterPath, largeImageUrl: baseLargeImageUrl+posterPath)
        }
        
        // Set content size.
        detailScrollView.contentSize = CGSize(width: detailScrollView.frame.size.width, height: movieInfoView.frame.origin.y + movieInfoView.frame.size.height)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
