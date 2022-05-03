//
//  DataModel.swift
//  flickrFeed
//
//  Created by Pu Yue - PU YUE on 2022/05/02.
//

import Foundation

struct DataModel: Codable {
    let title: String?
    let link: URL?
    let description: String?
    let modified: String?
    let generator: String?
    let items: [Item]
}

struct Item: Codable {
    let title: String
    let link: URL?
    let media: Media
    let date_taken: String
    let description: String
    let published: String
    let author: String
    let author_id: String?
    let tags: String
}

struct Media: Codable {
    let m: URL
}
