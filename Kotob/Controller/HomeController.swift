//
//  NewHomeController.swift
//  Kotob
//
//  Created by Mokhtar on 9/21/18.
//  Copyright © 2018 Mokhtar. All rights reserved.
//

import UIKit
import SDWebImage

class HomeController : UITableViewController{
    
    
    
    let mostRecentCellID = "mostRecent"
    let categoryCellID = "categoryCell"
    
    struct APIUrls {
        static var mostRecentAPI = "https://api.hindawi.org/cbx/kalimat/list/most.recent.pagination/return.type/json/lastid/%7Blastid%7D/pagesize/%7Bpagesize%7D/fields/cover.1536x2048,thumb.304x406/"
        static var mostDownloadedAPI = "https://api.hindawi.org/cbx/kalimat/list/most.downloaded.pagination/return.type/json/lastid/%7Blastid%7D/pagesize/%7Bpagesize%7D/fields/cover.1536x2048,thumb.304x406/"
    }
    
    var recentBooksArray = [Book]()
    var mostDownloadedArray = [Book]()

    let HomeScreenQueue = DispatchQueue(label: "com.kotob.mostRecent",qos: .userInteractive,attributes: .concurrent)
    
    
    
    fileprivate func getBooks() {
        let group = DispatchGroup()
        
        HomeScreenQueue.async {
            group.enter()
            HindawiAPI.getAHomeCategory(urlString: APIUrls.mostDownloadedAPI) { (bookCategory: BooksCategory) in
                self.mostDownloadedArray = bookCategory.books
                group.leave()
            }
        }
        
        
        HomeScreenQueue.async {
            group.enter()
            HindawiAPI.getAHomeCategory(urlString: APIUrls.mostRecentAPI) { (bookCategory: BooksCategory) in
                self.recentBooksArray = bookCategory.books
                group.leave()            }
        }
        
        let workItem = DispatchWorkItem {
            self.tableView.reloadData()
        }
        group.notify(queue: .main, work: workItem)
        
    }
    
    
    
    
    fileprivate func registeringTableViewCell() {
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: categoryCellID)
    }
    
    fileprivate func setingUpViewAppearance() {
        view.backgroundColor = UIColor(r: 243, g: 245, b: 248)
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
    }
    
    fileprivate func addingBarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "user"), style: .plain, target: self, action: #selector(showUserProfile))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setingUpViewAppearance()
        
        addingBarButtons()
        
        registeringTableViewCell()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBooks()
    }
    
    @objc fileprivate func showUserProfile() {
        print("123")
    }
    
    
    @objc func handleMoreButton() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        let moreController = MoreOfACategoryController(collectionViewLayout: layout)
        moreController.category = .mostRecent
        navigationController?.pushViewController(moreController, animated: true)
    }
    
    @objc func handleMoreButton2() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        let moreController = MoreOfACategoryController(collectionViewLayout: layout)
        moreController.category = .mostDownloaded
        navigationController?.pushViewController(moreController, animated: true)
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
            cell.booksArray = recentBooksArray
            cell.width = 188.6
            cell.height = 310.5
            cell.isMostRecentCategoryType = true
        } else {
            cell.mostDownloadedBookArray = mostDownloadedArray
            cell.width = 127.1
            cell.height = 169.61
            cell.isMostRecentCategoryType = false
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 350
        } else {
            return 200
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 22
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView : TableViewHeader = {
            let headerView = TableViewHeader()
            return headerView
        }()
        
        
        if section == 0 {
            headerView.headerTitle.text = "احدث الكتب"
            headerView.moreButton.addTarget(self, action: #selector(handleMoreButton), for: .touchUpInside)
            
        } else {
            headerView.headerTitle.text = "الاكثر تحميلا"
            headerView.moreButton.addTarget(self, action: #selector(handleMoreButton2), for: .touchUpInside)
        }
        headerView.headerTitle.font = UIFont.textStyle
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    
}
