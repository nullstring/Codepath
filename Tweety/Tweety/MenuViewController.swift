//
//  MenuViewController.swift
//  Tweety
//
//  Created by Harsh Mehta on 10/5/17.
//  Copyright © 2017 Harsh Mehta. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuTableView: UITableView!
    
    private var tweetsVC: UIViewController!
    private var mentionsVC: UIViewController!
    private var profileVC: UIViewController!
    
    var viewControllers: [UIViewController] = []
    var menuNames: [String] = ["Home", "Mentions", "Profile"]
    
    var hamburgerViewController: HamburgerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        tweetsVC = storyboard.instantiateViewController(withIdentifier: "TweetsNavigationVC")
        mentionsVC = storyboard.instantiateViewController(withIdentifier: "MentionsNavigationVC")
        profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileNavigationVC")
        
        viewControllers.append(tweetsVC)
        viewControllers.append(mentionsVC)
        viewControllers.append(profileVC)
        
        hamburgerViewController.contentViewController = tweetsVC
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.menuLabel.text = menuNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuTableView.deselectRow(at: indexPath, animated: true)
        
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
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
