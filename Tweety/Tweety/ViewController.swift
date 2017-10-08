//
//  ViewController.swift
//  Tweety
//
//  Created by Harsh Mehta on 9/26/17.
//  Copyright © 2017 Harsh Mehta. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTwitterLoginButtonTap(_ sender: Any) {
        TwitterClient.sharedInstance?.login(onSuccess: { 
            print("Login success")
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let haamburgerViewController = mainStoryboard.instantiateViewController(withIdentifier: "HamburgerViewController") as! HamburgerViewController
            let menuViewController = mainStoryboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
            menuViewController.hamburgerViewController = haamburgerViewController
            haamburgerViewController.menuViewController = menuViewController
            TwitterClient.sharedInstance?.setCurrentUser()
            self.present(haamburgerViewController, animated: true, completion: nil)
        }, onFailure: { (error: Error) in
            print("Login failure")
        })
    }

}

