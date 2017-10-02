//
//  LoginViewController.swift
//  Hallo
//
//  Created by Harsh Mehta on 9/27/17.
//  Copyright © 2017 Harsh Mehta. All rights reserved.
//

import Parse
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignup(_ sender: Any) {
        registerUser()
    }
    
    @IBAction func onLogin(_ sender: Any) {
        loginUser()
    }
    
    func presentAlert(message: String) {
        let alertController = UIAlertController(title: "Title", message: message, preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        self.present(
            alertController, animated: true, completion: nil)
    }

    func registerUser() {
        // initialize a user object
        let newUser = PFUser()

        newUser.username = emailInput.text
        newUser.email = emailInput.text
        newUser.password = passInput.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                self.presentAlert(message: error.localizedDescription)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
            }
        }   
    }
    
    func loginUser() {
        
        let username = emailInput.text ?? ""
        let password = passInput.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
                self.presentAlert(message: error.localizedDescription)
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
                
                self.performSegue(withIdentifier: "LoginSegue", sender: self)
            }
        }   
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
