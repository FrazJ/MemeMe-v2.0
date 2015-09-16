//
//  MemeEditorViewController.swift
//  MemeMe v2.0
//
//  Created by Frazer Hogg on 07/09/2015.
//  Copyright (c) 2015 HomeProjects. All rights reserved.
//

import UIKit
import AVFoundation

class MemeEditorViewController: UIViewController, UITextFieldDelegate {

    // MARK: Properties
    var topConstraint : NSLayoutConstraint!
    var bottomConstraint : NSLayoutConstraint!
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "Impact", size: 40)!,
        NSStrokeWidthAttributeName : NSNumber(float: -3.0)
    ]
    
    // MARK: Outlets
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    
    
    // MARK: View lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup the top textField
        configureTextField(topTextField,
            text: "TOP",
            delegate: self,
            attributes: memeTextAttributes,
            alignment: .Center)
        
        //Setup the bottom textField
        configureTextField(bottomTextField,
            text: "BOTTOM",
            delegate: self,
            attributes: memeTextAttributes,
            alignment: .Center)
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Disable the camera button if the device doesn't have a camera
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        
        //Disable the share button if the user hasn't chosen an image
        shareButton.enabled = memeImageView.image != nil
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
    
    ///Function sets the constraints for the top and bottom text fields, ensuring they are 
    ///positioned correctly based on the postion the image that has been selected.
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
    
    ///Function used to configure textFields in the view
    func configureTextField(textField: UITextField, text: String, delegate: UITextFieldDelegate,
        attributes: [String : NSObject], alignment: NSTextAlignment) {
        
        textField.text = text
        textField.delegate = delegate
        textField.defaultTextAttributes = attributes
        textField.textAlignment = alignment
    }
    
}
