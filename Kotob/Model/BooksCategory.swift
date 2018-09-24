//
//  MostDownloadedWithPagination.swift
//  Kotob
//
//  Created by Mokhtar on 9/23/18.
//  Copyright © 2018 Mokhtar. All rights reserved.


import Foundation

struct BooksCategory: Codable {
    let books: [Book]
    let oldStyle: OldStyle
    let newStyle: NewStyle
    
    enum CodingKeys: String, CodingKey {
        case books = "Books"
        case oldStyle = "OldStyle"
        case newStyle = "NewStyle"
    }
}

struct Book: Codable {
    let documentType: Int?
    let rate: Float
    let downloadsCount: String
    let userRating: Int
    let tags: String
    let ratingsCount: String
    let bookURL: String
    let isFree: Int
    let price: String
    let epubCSSVersion: Int
    let approvalDate, title: String
    let coverURL, thumbURL: String
    let description: String
    let publishDate: String
    let itemNumber: Int
    let downloadURL: String
    let imageLastModfiedDate: String
    let authors: [Author]
    
    enum CodingKeys: String, CodingKey {
        case documentType = "DocumentType"
        case rate = "Rate"
        case downloadsCount = "DownloadsCount"
        case userRating = "UserRating"
        case tags = "Tags"
        case ratingsCount = "RatingsCount"
        case bookURL = "BookURL"
        case isFree, price
        case epubCSSVersion = "EpubCSSVersion"
        case approvalDate = "ApprovalDate"
        case title = "Title"
        case coverURL = "CoverURL"
        case thumbURL = "ThumbURL"
        case description = "Description"
        case publishDate = "PublishDate"
        case itemNumber = "ItemNumber"
        case downloadURL = "DownloadURL"
        case imageLastModfiedDate = "ImageLastModfiedDate"
        case authors = "Authors"
    }
}

struct Author: Codable {
    let authorName: String
    let role: String
    let itemNumber: String
    
    enum CodingKeys: String, CodingKey {
        case authorName
        case role = "Role"
        case itemNumber = "ItemNumber"
    }
}

struct NewStyle: Codable {
    let appStyleURL, epubStyleURL: String
    let styleVersion: String
    
    enum CodingKeys: String, CodingKey {
        case appStyleURL, epubStyleURL
        case styleVersion = "StyleVersion"
    }
}

struct OldStyle: Codable {
    let styleURL: String
    let styleVersion: String
    
    enum CodingKeys: String, CodingKey {
        case styleURL = "StyleURL"
        case styleVersion = "StyleVersion"
    }
}
