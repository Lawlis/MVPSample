//
//  ApiService.swift
//  MVPSample
//
//  Created by Laurynas Letkauskas on 2022-04-21.
//

import Foundation

class LordOfTheRingsApi {
    
    // MARK: - Constants
    let baseUrl: URL = URL(string: "https://the-one-api.dev/v2")!
    
    enum Paths: String {
        case books = "/book"
    }
    
    private var session = URLSession.shared
    
    func getBooks() async throws -> BooksResponse {
        let endpoint = baseUrl.appendingPathComponent(Paths.books.rawValue)
        
        let (data, _) = try await session.data(from: endpoint)
        let decoder = JSONDecoder()
        
        return try decoder.decode(BooksResponse.self, from: data)
    }
}
