//
//  Article.swift
//  ArticleApp
//
//  Created by Vanshika on 29/07/2022.
//

import Foundation

// MARK: - Welcome
struct APiResponse: Codable {
    let status: String
    let results: [Article]
}

// MARK: - Result
struct Article: Codable {
    let uri: String
    let url: String
    let id, assetID: Int
    let publishedDate, updated, section, subsection: String
    let byline: String
    let title, abstract: String
    let media: [Media]
    let etaID: Int
    
    enum CodingKeys: String, CodingKey {
        case uri, url, id
        case assetID = "asset_id"
        case publishedDate = "published_date"
        case updated, section, subsection
        case byline, title, abstract
        case media
        case etaID = "eta_id"
    }
}

// MARK: - Media
struct Media: Codable {
    let mediaMetadata: [MediaMetadatum]

    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
}

// MARK: - MediaMetadatum
struct MediaMetadatum: Codable {
    let url: String
    let format: String
    let height, width: Int
}

