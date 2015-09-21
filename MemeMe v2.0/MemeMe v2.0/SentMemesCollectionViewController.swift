//
//  SentMemesCollectionViewController.swift
//  MemeMe v2.0
//
//  Created by Frazer Hogg on 04/09/2015.
//  Copyright (c) 2015 HomeProjects. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {

    // MARK: - Outlets
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    // MARK: - Properties
    
    ///Property that holds an array of the Memes that have been created and sent. The array is
    ///obtained from the AppDelegate.
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    
    // MARK: - ViewController lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Configures the UICollectionViewFlowLayout
        let space : CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3
        
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)

        //Set the background of the collection view
        collectionView?.backgroundColor = .whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        //Gets the latest collection of Memes
        collectionView!.reloadData()
        
        //Make sure the tab bar is visuble when this viewController loads
        tabBarController?.tabBar.hidden = false
        
    }
    
    // MARK: - Actions
    
    @IBAction func createNewMeme(sender: UIBarButtonItem) {
        let memeEditorController = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        
        navigationController!.pushViewController(memeEditorController, animated: true)
    }

    
    // MARK: - CollectionView data source

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // TODO: - Add the code to setup each of the collection cells
        let collectionCell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]

        collectionCell.setCellImage(meme.memedImage)
        
        return collectionCell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //Instantiate the MemeDeatailViewController
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewcontroller") as! MemeDetailViewController
        
        //Get the meme for the row that has been selected
        let meme = memes[indexPath.row]
        
        //Pass the meme and it's index to the viewController
        detailController.meme = meme
        detailController.memeIndex = indexPath.row
        
        //Push the detailed view controoler onto the stack, making it display
        navigationController!.pushViewController(detailController, animated: true)
    }
}

