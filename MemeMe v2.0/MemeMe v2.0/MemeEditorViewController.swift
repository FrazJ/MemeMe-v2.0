//
//  MemeEditorViewController.swift
//  MemeMe v2.0
//
//  Created by Frazer Hogg on 07/09/2015.
//  Copyright (c) 2015 HomeProjects. All rights reserved.
//

import UIKit
import AVFoundation

class MemeEditorViewController: UIViewController {

    // MARK: Properties
    var topConstraint : NSLayoutConstraint!
    var bottomConstraint : NSLayoutConstraint!
    
    // MARK: Outlets
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var memeImageView: UIImageView!
    
    // MARK: View lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutTextFields()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Functions
    
    /* Function sets the constraints for the top and bottom text fields, ensuring they are positioned correctly based upon the image that has been selected */
    func layoutTextFields() {
        
        //Remove any existing constraints
        if topConstraint != nil {
            view.removeConstraint(topConstraint)
        }
        
        if bottomConstraint != nil {
            view.removeConstraint(bottomConstraint)
        }
        
        //Get the position of the image inside the imageView
        let size = memeImageView.image != nil ? memeImageView.image!.size : memeImageView.frame.size
        let frame = AVMakeRectWithAspectRatioInsideRect(size, memeImageView.bounds)
        
        //A margin for the new constrains; 10% of the frame's height
        let margin = frame.origin.y + frame.size.height * 0.10
        
        //Create and add the new constraints
        topConstraint = NSLayoutConstraint(
            item: topTextField,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: memeImageView,
            attribute: .Top,
            multiplier: 1.0,
            constant: margin)
        view.addConstraint(topConstraint)
        
        bottomConstraint = NSLayoutConstraint(
            item: bottomTextField,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: memeImageView,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: -margin)
        view.addConstraint(bottomConstraint)
        
    }
    
}
