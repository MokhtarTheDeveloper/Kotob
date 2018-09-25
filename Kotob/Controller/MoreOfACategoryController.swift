//
//  MoreOfACategoryController.swift
//  
//
//  Created by Mokhtar on 9/24/18.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "Cell"

class MoreOfACategoryController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    
    var books = [Book]()
    
    enum Category : String {
        case mostRecent = "https://api.hindawi.org/cbx/kalimat/list/most.recent/return.type/json/fields/cover.1536x2048,thumb.304x406/"
        case mostDownloaded = "https://api.hindawi.org/cbx/kalimat/list/most.downloaded/return.type/json/fields/cover.1536x2048,thumb.304x406/"
    }
    
    var category: Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollcetionView()

    }
    
    
    fileprivate func prepareCollcetionView() {
        collectionView?.backgroundColor = UIColor(r: 243, g: 245, b: 248)
        collectionView?.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let nub = UINib(nibName: "MostRecentCell", bundle: nil)
        collectionView?.register(nub, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if category == Category.mostRecent {
            HindawiAPI.getAHomeCategory(urlString: category.rawValue) { (booksArray: BooksCategory) in
                self.books = booksArray.books
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                    
                }
            }
            
            
        } else {
            HindawiAPI.getAHomeCategory(urlString: category.rawValue) { (booksArray: BooksCategory) in
                self.books = booksArray.books
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                    
                }
            }
            
        }
        
    }


    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return books.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MostRecentCell
        let thumbUrlString = books[indexPath.item].thumbURL
        let thumbUrl = URL(string: thumbUrlString)
        cell.bookCover.sd_setImage(with: thumbUrl, completed: nil)
        cell.bookCover.layer.cornerRadius = 0
        cell.bookCover.layer.masksToBounds = false
        
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((view.frame.width) - 4 * 8) / 3
        let height = 192 * width / 114
        return CGSize(width: width, height: height)
}
}
