//
//  SentMemesCollectionViewController.swift
//  MemeMe v2.0
//
//  Created by Frazer Hogg on 04/09/2015.
//  Copyright (c) 2015 HomeProjects. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {

    // MARK: - Properties
    
    /** 
        Property that holds an array of the Memes that have been created and sent. The array is
        obtained from the AppDelegate.
    */
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    
    // MARK: - ViewController lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //Test commit


}

