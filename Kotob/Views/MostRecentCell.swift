//
//  MostRecentCell.swift
//  Kotob
//
//  Created by Mokhtar on 9/21/18.
//  Copyright © 2018 Mokhtar. All rights reserved.
//

import UIKit

class MostRecentCell: UICollectionViewCell {
    
    @IBOutlet weak var bookCover: UIImageView!
    
    @IBOutlet weak var downloaded: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
    }
}
