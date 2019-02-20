//
//  SearchResult.swift
//  iTunesSearchAPI
//
//  Created by Struzinski, Mark - Mark on 2/18/19.
//  Copyright © 2019 Struzinski, Mark - Mark. All rights reserved.
//

import Foundation

/// A result returned from the iTunes Search API. Swift struct SearchResult: Decodable {
/// The name of the track, song, video, TV episode, and so on.

struct SearchResult: Decodable {
    let trackName: String?
    /// The explicitness of the track.
    let trackExplicitness: Explicitness?
    /// An iTunes Store URL for the content.
    let trackViewURL: URL?
    /// A URL referencing the 30-second preview file
    /// for the content associated with the returned media type. /// - Note: This is available when media type is track.
    let previewURL: URL?
    /// The name of the artist, and so on.
    let artistName: String?
    /// The name of the album, TV season, audiobook, and so on.
    let collectionName: String?
    /// A URL for the artwork associated with the returned media type.
    private let artworkURL100: URL?
}

extension SearchResult {
    private enum CodingKeys: String, CodingKey {
        case trackName
        case trackExplicitness
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artistName
        case collectionName
        case artworkURL100 = "artworkUrl100"
    }
}

extension SearchResult {
    func artworkURL(size dimension: Int = 100) -> URL? {
        guard dimension > 0,
            dimension != 100,
            var url = self.artworkURL100 else {
            return self.artworkURL100
        }
        
        url.deleteLastPathComponent()
        url.appendPathComponent("\(dimension)x\(dimension)bb.jpg")
        
        return url
    }
}
