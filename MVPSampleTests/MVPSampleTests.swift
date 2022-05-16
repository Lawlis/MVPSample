//
//  MVPSampleTests.swift
//  MVPSampleTests
//
//  Created by Laurynas Letkauskas on 2022-04-21.
//

import XCTest
@testable import MVPSample

class BooksViewMock: BooksView {
    var onBooksRetrieved_callCount = 0
    
    let onBooksRetrievedFinishedExpectation = XCTestExpectation(description: "onBooksRetrieved finished")
    
    func onBooksRetrieved(names: [String]) {
        onBooksRetrieved_callCount += 1
        onBooksRetrievedFinishedExpectation.fulfill()
    }
}

class ApiServiceMock: LordOfTheRingsApiInterface {
    var getBooks_callCount = 0
    
    let getBooksFinishedExpectation = XCTestExpectation(description: "get books finished")

    func getBooks() async throws -> BooksResponse {
        getBooks_callCount += 1
        getBooksFinishedExpectation.fulfill()
        return BooksResponse(docs: [], total: 0, limit: 0, offset: 0, page: 0, pages: 0)
    }
}

class MVPSampleTests: XCTestCase {
    
    var mockBooksView: BooksViewMock!
    var mockApiService: ApiServiceMock!
    var booksViewPresenter: BooksPresenter!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        mockBooksView = BooksViewMock()
        mockApiService = ApiServiceMock()
        
        
        booksViewPresenter = BooksPresenter(
            view: mockBooksView
        )
        
        booksViewPresenter.apiService = mockApiService
    }

    func test_when_viewDidLoad_getBooks_isCalled() {
        booksViewPresenter.viewDidLoad()
        
        wait(for: [mockApiService.getBooksFinishedExpectation], timeout: 0.1)
        XCTAssertEqual(mockApiService.getBooks_callCount, 1)
        wait(for: [mockBooksView.onBooksRetrievedFinishedExpectation], timeout: 0.1)
        XCTAssertEqual(mockBooksView.onBooksRetrieved_callCount, 1)
    }

}
