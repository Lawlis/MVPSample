//
//  BooksViewPresenter.swift
//  MVPSample
//
//  Created by Laurynas Letkauskas on 2022-04-21.
//

import Foundation
import Resolver

protocol BooksViewPresenter: AnyObject {
    init(view: BooksView)
    func viewDidLoad()
}

class BooksPresenter: BooksViewPresenter {
    
    @MainActor weak var view: BooksView?
    @Injected var apiService: LordOfTheRingsApi
    
    required init(view: BooksView) {
        self.view = view
    }
    
    func viewDidLoad() {
        print("view did load")
        
        retrieveBooks()
    }
    
    private func retrieveBooks() {
        Task {
            let booksResponse = try await apiService.getBooks()
            let bookNames = booksResponse.docs.map({ $0.name })
            DispatchQueue.main.async {
                self.view?.onBooksRetrieved(names: bookNames)
            }
        }
    }
    
    
}
