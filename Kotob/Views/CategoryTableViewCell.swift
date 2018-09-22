//
//  CategoryCell.swift
//  Kotob
//
//  Created by Mokhtar on 9/22/18.
//  Copyright © 2018 Mokhtar. All rights reserved.
//

import UIKit



class CategoryTableViewCell : UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var width, height: CGFloat!
    
    var BooksArray = [Book](){
        didSet{
            categoryCollectionView.reloadData()
        }
    }
    
    let mostRecentCellID = "mostRecent"
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryCollectionView.backgroundColor = UIColor(r: 243, g: 245, b: 248)
        categoryCollectionView.register(UINib(nibName: "MostRecentCell", bundle: nil), forCellWithReuseIdentifier: mostRecentCellID)
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        UIView.appearance().semanticContentAttribute = .forceRightToLeft

    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.scrollIndicatorColor = UIColor.nagwaOrange
        scrollView.indicatorStyle = .black
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return BooksArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mostRecentCellID, for: indexPath) as! MostRecentCell
        
        let urlString = BooksArray[indexPath.item].thumbURL
        let url = URL(string: urlString)
        cell.bookCover.sd_setImage(with: url, completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: width, height: height)
    }
    

}
