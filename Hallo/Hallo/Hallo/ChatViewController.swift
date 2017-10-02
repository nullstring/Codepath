//
//  ChatViewController.swift
//  Hallo
//
//  Created by Harsh Mehta on 9/27/17.
//  Copyright © 2017 Harsh Mehta. All rights reserved.
//

import Parse
import ParseLiveQuery
import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var messageInput: UITextField!
    
    // make sure to declare both client and subscriptions variables outside lifecycle methods
    // otherwise, websocket delegate methods won't fire
    var client : ParseLiveQuery.Client!
    var subscription : Subscription<Message>!
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.estimatedRowHeight = 100
        messageTableView.rowHeight = UITableViewAutomaticDimension

        let query = PFQuery(className:"Message")
        // Sorts the results in descending order by the score field if the previous sort keys are equal.
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print(object.objectId!)
                    }
                }
                self.messages = objects! as! NSArray
                self.messageTableView.reloadData()
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.localizedDescription)")
            }
        }
        
        // Do any additional setup after loading the view.
        var messageQuery: PFQuery<Message> {
            return (Message.query()!
                .whereKeyExists("text")
                .order(byAscending: "createdAt")) as! PFQuery<Message>
        }
        client = ParseLiveQuery.Client()
        subscription = client.subscribe(messageQuery)
            // handle creation events, we can also listen for update, leave, enter events
            .handle(Event.created) { _, message in
                print("\(message.text!)")
                self.messages.add(message)
                DispatchQueue.main.async {
                    self.messageTableView.reloadData()
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSendTap(_ sender: Any) {
        let message = Message()
        message.text = messageInput.text
        message.user = PFUser.current()
        message.saveInBackground { (success: Bool, error: Error?) in
            if success {
                print("Message saved")
            } else {
                print("Message failed. \(error!.localizedDescription)")
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        let message = messages[indexPath.row] as! Message
        cell.messageLabel.text = message.text
        return cell
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
