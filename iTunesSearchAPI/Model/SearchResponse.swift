//
//  SearchResponse.swift
//  iTunesSearchAPI
//
//  Created by Struzinski, Mark - Mark on 2/18/19.
//  Copyright © 2019 Struzinski, Mark - Mark. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    let results: [SearchResult]
}

extension SearchResponse {
    var nonExplicitResults: [SearchResult] {
        return self.results.filter({ result in
            return result.trackExplicitness != .explicit
        })
    }
}
