//
//  SentMemesTableViewController.swift
//  MemeMe v2.0
//
//  Created by Frazer Hogg on 04/09/2015.
//  Copyright (c) 2015 HomeProjects. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {

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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView!.reloadData()
    }
    
    
    // MARK: - TableView data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            
            let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
            
            //Get the meme from the array corresponding to the row
            var meme = memes[indexPath.row]
            
            //Create the cell text from the top and bottom meme text, then make it the cell text
            var topMemeText = meme.topText
            var bottomMemetext = meme.bottomText
            var cellText = topMemeText + " " + bottomMemetext
            cell.textLabel?.text = cellText
            
            //Add the memeImage to the cell
            cell.imageView?.image = meme.memedImage
            
            return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // TODO: - Add the code to switch to the Meme Detail VC when a row is selected
    }
}

