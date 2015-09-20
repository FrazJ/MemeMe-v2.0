//
//  MemeEditorViewController.swift
//  MemeMe v2.0
//
//  Created by Frazer Hogg on 07/09/2015.
//  Copyright (c) 2015 HomeProjects. All rights reserved.
//

import UIKit
import AVFoundation

class MemeEditorViewController:
UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    // MARK: Properties
    var topConstraint : NSLayoutConstraint!
    var bottomConstraint : NSLayoutConstraint!
    var shareButton : UIBarButtonItem!
    
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
//    @IBOutlet weak var shareButton: UIBarButtonItem!
//    @IBOutlet weak var topToolbar: UINavigationBar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    
    
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
        
        //Creates a new button with the Actin system icon
        shareButton = UIBarButtonItem(
            barButtonSystemItem: .Action,
            target: self,
            action: "shareMemedImage:")
     
        //Add the shareButton to the navigation bar
        navigationItem.rightBarButtonItem = shareButton
        
        //Hides the tab bar
        tabBarController?.tabBar.hidden = true
        
        //Disable the camera button if the device doesn't have a camera
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        
        //Disable the share button if the user hasn't chosen an image
        shareButton.enabled = memeImageView.image != nil
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Displays the tab bar
        tabBarController?.tabBar.hidden = false
        
        unsubscribeFromKeyboardNotifications()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutTextFields()
    }
    
    
    // MARK: Actions
    
    ///Function is called when the user presses either the Camera or Album buttons
    @IBAction func pickImage(sender: UIBarButtonItem) {
        
        //Creates a imagePickerViewController and assigns this viewController as it's delegate
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        //Checks the title of the sender and displays the camera or photo library accordingly
        if sender.title == "Album" {
            imagePicker.sourceType = .PhotoLibrary
            presentViewController(imagePicker, animated: true, completion: nil)
        } else {
            imagePicker.sourceType = .Camera
            presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    // MARK: Methods
    
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
    
    ///Function that adds this ViewController as an observer to keyboard notifications
    func subscribeToKeyboardNotifications() {
        
        //Subscribe to be notified when the keyboard will be displayed
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "keyboardWillShow:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        
        //Subscribe to be notified when the keyboard will be hidden
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "keyboardWillHide:",
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    ///Function that removes this ViewController as an observer for keyboard notifications
    func unsubscribeFromKeyboardNotifications() {
        
        //Unsubscribe to be notified when the keyboard will be displayed
        NSNotificationCenter.defaultCenter().removeObserver(
            self,
            name: UIKeyboardWillShowNotification,
            object: nil)
        
        //Unsubscribe to be notified when the keyboard will be hidden
        NSNotificationCenter.defaultCenter().removeObserver(
            self,
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    ///Function is called when the user presses the share button in the navigation bar. It takes a
    /// screenshot of the image currently on the screen and passes it to an ActivityController
    func shareMemedImage(sender: UIBarButtonItem) {
        
        //Generated a memed image
        let memedImage = generateMemedImage()
        
        //Creates a new ActivityViewController
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        //Closure for handling the users action with the ActivityViewController
        activityViewController.completionWithItemsHandler = { activity, completed, items, error in
            if completed {
                
                //Save the image
                self.save()
                
                //Dismiss the view controller
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    ///Function that generates a memeImage from the image and text in the memeEditor
    func generateMemedImage() -> UIImage {
        
        //Hide the navigationbar and toolbar
        navigationController?.navigationBar.hidden = true
        bottomToolbar.hidden = true
        
        //Size of the selected image
        let imageSize = memeImageView.image!.size
        
        //Frame of the image after having aspect fit applied
        var frame = AVMakeRectWithAspectRatioInsideRect(imageSize, memeImageView.bounds)
        
        //Frame update to CGRect rounded to the nearest pixel
        frame = CGRectMake(
            ceil(frame.origin.x),
            ceil(frame.origin.y),
            floor(frame.size.width),
            floor(frame.size.height))
        
        //CGRect fo the drawInHierarchyInRect call
        let rect = CGRectMake(
            -frame.origin.x,
            -frame.origin.y,
            view.frame.size.width,
            view.frame.size.height)
        
        
        //Render view to an image
        UIGraphicsBeginImageContext(frame.size)
        view.drawViewHierarchyInRect(rect, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //Show the navigationbar and toolbar
        navigationController?.navigationBar.hidden = false
        bottomToolbar.hidden = false
        
        return memedImage
    }
    
    ///Function that saves the memedImage
    func save() {
        //Create the memedImage
        let memedImage = generateMemedImage()
        
        //Create a meme object to store the memed image
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!,
            originalImage: memeImageView.image!, memedImage: memedImage)
        
        //Add the meme to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    ///Function that raises the view up out the way of the keyboard
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y -= getKeyboardHeight(notification)
            print(getKeyboardHeight(notification))
        }
    }
    
    ///Function that lowers the view when the keyboard is hidden
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y = 0
        }
    }
    
    ///Fucntion that retrives the height of a keyboard
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo! [UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    
    // MARK: ImagePickerControllerDelegate functions
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //Passes the image selected by the user to to the memeImageView
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImageView.image = image
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: UITextFieldDelegate functions
    
    //Function causes the active textField to resignFirstResponder when 'Return' is hit
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //Function ensures that any characters entered are in upper case
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {

        textField.text = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string.uppercaseString)
        
        return false
    }
    
}
