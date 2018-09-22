//
//  NewHomeController.swift
//  Kotob
//
//  Created by Mokhtar on 9/21/18.
//  Copyright © 2018 Mokhtar. All rights reserved.
//

import UIKit
import SDWebImage

class NewHomeController : UITableViewController{
    
    let mostRecentCellID = "mostRecent"
    let categoryCellID = "categoryCell"
    
    struct APIUrls {
        static var mostRecentAPI = "https://api.hindawi.org/cbx/kalimat/list/most.recent.pagination/return.type/json/lastid/%7Blastid%7D/pagesize/%7Bpagesize%7D/fields/cover.1536x2048,thumb.304x406/"
        static var mostDownloadedAPI = "https://api.hindawi.org/cbx/kalimat/list/most.recent.pagination/return.type/json/lastid/%7Blastid%7D/pagesize/%7Bpagesize%7D/fields/cover.1536x2048,thumb.304x406/"
    }
    
    var recentBooksArray = [Book]()
    var mostDownloadedArray = [Book]()

    
    fileprivate func getRecentBooks() {
        HindawiAPI.getMostRecent(urlString: APIUrls.mostRecentAPI) { (bookCategory) in
            self.recentBooksArray = bookCategory.books
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    fileprivate func getMostDownloadedBook() {
        
        HindawiAPI.getMostRecent(urlString: APIUrls.mostDownloadedAPI) { (bookCategory) in
            self.mostDownloadedArray = bookCategory.books
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 243, g: 245, b: 248)
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "user"), style: .plain, target: self, action: #selector(showUserProfile))
        getRecentBooks()
        
        getMostDownloadedBook()
        
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: categoryCellID)
    }
    
    @objc fileprivate func showUserProfile() {
        print("123")
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCellID, for: indexPath) as! CategoryTableViewCell
        if indexPath.section == 0 {
            cell.BooksArray = recentBooksArray
            cell.width = 188.6
            cell.height = 310.5
        } else {
            cell.BooksArray = mostDownloadedArray
            cell.width = 127.1
            cell.height = 209.25
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 350
        } else {
            return 270
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headeView = TableViewHeader()
        if section == 0 {
            headeView.headerTitle.text = "احدث الكتب"
            
        } else {
            headeView.headerTitle.text = "الاكثر تحميلا"

        }
        headeView.headerTitle.font = UIFont.textStyle
        return headeView
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let fview = UIView()
        return fview
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    
}
