//
//  MemeDetailViewController.swift
//  MemeMe v2.0
//
//  Created by Frazer Hogg on 07/09/2015.
//  Copyright (c) 2015 HomeProjects. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    // MARK: Properties
    var meme : Meme!
    
    // MARK: Outlets
    @IBOutlet weak var memeImageView: UIImageView!
    
    // MARK: View lifecycle functions
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Display the memedImage of the meme
        memeImageView.image = meme.memedImage
        
        //Hides the tab bar
        tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Displays the tab bar
        tabBarController?.tabBar.hidden = false
    }
    
}
