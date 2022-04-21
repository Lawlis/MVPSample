//
//  LordOfTheRings.swift
//  MVPSample
//
//  Created by Laurynas Letkauskas on 2022-04-21.
//

import Foundation

// MARK: - Books
struct BooksResponse: Codable {
    let docs: [Doc]
    let total, limit, offset, page: Int
    let pages: Int
}

// MARK: - Doc
struct Doc: Codable {
    let id, name: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
    }
}
