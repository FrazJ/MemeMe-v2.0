//
//  MemeCollectionViewCell.swift
//  MemeMe v2.0
//
//  Created by Frazer Hogg on 07/09/2015.
//  Copyright (c) 2015 HomeProjects. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: Outlets
    @IBOutlet weak var memeImageView: UIImageView!
    
    // MARK: Functions
    
    ///Function sets the image of the cell
    func setCellImage(image: UIImage) {
        memeImageView.image = image
    }
}
