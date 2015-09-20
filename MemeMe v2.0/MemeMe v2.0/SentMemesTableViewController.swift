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
    
    
    // MARK: - Actions
    
    @IBAction func createNewMeme(sender: UIBarButtonItem) {
        
        let memeEditorController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        
        navigationController!.pushViewController(memeEditorController, animated: true)
    }
    
    
    // MARK: - TableView data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            
            let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
            
            //Get the meme from the array corresponding to the row
            let meme = memes[indexPath.row]
            
            //Create the cell text from the top and bottom meme text, then make it the cell text
            let topMemeText = meme.topText
            let bottomMemetext = meme.bottomText
            let cellText = topMemeText + " " + bottomMemetext
            cell.textLabel?.text = cellText
            
            //Add the memeImage to the cell
            cell.imageView?.image = meme.memedImage
            
            return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //Instantiate the MemeDeatailViewController
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewcontroller") as! MemeDetailViewController
        
        //Get the meme for the row that has been selected
        let meme = memes[indexPath.row]
     
        //Pass the meme to the viewController
        detailController.meme = meme
        
        //Push the detailed view controoler onto the stack, making it display
        navigationController!.pushViewController(detailController, animated: true)
    }
}

