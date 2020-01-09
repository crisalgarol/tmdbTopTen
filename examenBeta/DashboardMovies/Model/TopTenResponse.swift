//
//  topTenResponse.swift
//  examenBeta
//
//  Created by Cristian Olmedo on 08/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import Foundation

class TopTenResponse: Codable {
    let page, totalResults, totalPages: Int?
    let results: [MovieItemResponse]?

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }

    init(page: Int?, totalResults: Int?, totalPages: Int?, results: [MovieItemResponse]?) {
        self.page = page
        self.totalResults = totalResults
        self.totalPages = totalPages
        self.results = results
    }
}
