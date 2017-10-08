//
//  ViewController.swift
//  Canvas
//
//  Created by Harsh Mehta on 10/4/17.
//  Copyright © 2017 Harsh Mehta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var trayView: UIView!
    
    var trayViewCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    
    var newlyCreatedFace: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        trayCenterWhenOpen = trayView.center
        
        trayView.frame = CGRect(x: parentView.frame.origin.x, y: parentView.frame.height - 40, width: parentView.frame.width, height: trayView.frame.height)
        
        trayCenterWhenClosed = trayView.center
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func AnimateUp() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: .curveEaseIn, animations: {
            self.trayView.center = self.trayCenterWhenOpen
        }, completion: nil)
    }
    
    func AnimateDown() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseIn, animations: {
            self.trayView.center = self.trayCenterWhenClosed
        }, completion: nil)
    }
    
    @IBAction func onPanTray(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let point  = panGestureRecognizer.location(in: parentView)
        
        if panGestureRecognizer.state == .began {
            print("Gesture began at: \(point)")
            trayViewCenter = trayView.center
        } else if panGestureRecognizer.state == .changed {
            print("Gesture changed at: \(point)")
            trayView.center = CGPoint(x: trayViewCenter.x, y: trayViewCenter.y + panGestureRecognizer.translation(in: parentView).y)
        } else if panGestureRecognizer.state == .ended {
            print("Gesture ended at: \(point)")
            if panGestureRecognizer.velocity(in: parentView).y < 0 {
                AnimateUp()
            } else {
                AnimateDown()
            }
        }
        
        
    }
    
    func isTrayOpen() -> Bool {
        return trayView.center == self.trayCenterWhenOpen
    }
    
    func isTrayClosed() -> Bool {
        return trayView.center == self.trayCenterWhenClosed
    }
    
    @IBAction func onTrayTap(_ sender: UITapGestureRecognizer) {
        print("Tray tap")
        
        if !(isTrayOpen() || isTrayClosed()) {
            return
        }
        
        if isTrayOpen() {
            AnimateDown()
        } else if isTrayClosed() {
            AnimateUp()
        }
    }
    
    var initialCenter: CGPoint!
    @IBAction func onPanSmiley(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let point  = panGestureRecognizer.location(in: parentView)
        
        if panGestureRecognizer.state == .began {
            print("Gesture began at: \(point)")
            // Gesture recognizers know the view they are attached to
            let imageView = panGestureRecognizer.view as! UIImageView
            
            // Create a new image view that has the same image as the one currently panning
            newlyCreatedFace = UIImageView(image: imageView.image)
            
            // Add the new face to the tray's parent view.
            parentView.addSubview(newlyCreatedFace)
            
            // Initialize the position of the new face.
            newlyCreatedFace.center = imageView.center
            
            // Since the original face is in the tray, but the new face is in the
            // main view, you have to offset the coordinates
            newlyCreatedFace.center.y += trayView.frame.origin.y
            
            // Setup pan gesture recog on newly created image views.
            newlyCreatedFace.isUserInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onPanSmileyOutsideTray(_:))))
            newlyCreatedFace.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(onPinchSmileyOutsideTray(_:))))
            
            self.initialCenter = newlyCreatedFace.center
        } else if panGestureRecognizer.state == .changed {
            print("Gesture changed at: \(point)")
            newlyCreatedFace.center = CGPoint(x: initialCenter.x + panGestureRecognizer.translation(in: parentView).x, y: initialCenter.y + panGestureRecognizer.translation(in: parentView).y)
        } else if panGestureRecognizer.state == .ended {
            print("Gesture ended at: \(point)")
        }
    }
    
    var panImageViewCenter: CGPoint!
    func onPanSmileyOutsideTray(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let point  = panGestureRecognizer.location(in: parentView)
        
        if panGestureRecognizer.state == .began {
            print("Gesture began at: \(point)")
            // Gesture recognizers know the view they are attached to
            let imageView = panGestureRecognizer.view as! UIImageView
            panImageViewCenter = imageView.center
            imageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } else if panGestureRecognizer.state == .changed {
            print("Gesture changed at: \(point)")
            newlyCreatedFace.center = CGPoint(x: panImageViewCenter.x + panGestureRecognizer.translation(in: parentView).x, y: panImageViewCenter.y + panGestureRecognizer.translation(in: parentView).y)
        } else if panGestureRecognizer.state == .ended {
            print("Gesture ended at: \(point)")
            let imageView = panGestureRecognizer.view as! UIImageView
            imageView.contentScaleFactor = 0.5
            imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    func onPinchSmileyOutsideTray(_ pinchGestureRecognizer: UIPinchGestureRecognizer) {
        if pinchGestureRecognizer.state == .began {
        } else if pinchGestureRecognizer.state == .changed {
            let imageView = pinchGestureRecognizer.view as! UIImageView
            imageView.transform = CGAffineTransform(scaleX: pinchGestureRecognizer.scale, y: pinchGestureRecognizer.scale)
            
        } else if pinchGestureRecognizer.state == .ended {
            
        }
    }
}

