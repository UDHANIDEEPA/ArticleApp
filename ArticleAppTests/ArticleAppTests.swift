//
//  ArticleAppTests.swift
//  ArticleAppTests
//
//  Created by Vanshika on 31/07/2022.
//

import XCTest
@testable import ArticleApp

class when_app_is_launched: XCTestCase {
    var articleListVM: ArticleListViewModel? = nil
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        articleListVM = ArticleListViewModel()
    }
    
    func test_should_fetch_all_most_Viewed_articles_list() {
        
//        let app = XCUIApplication()
//        continueAfterFailure = false
//        app.launch()
        
        var result: Result<Bool, NYError>?
        
        // Create the expectation.
        let expectation = self.expectation(description: "Waiting for the retrieveAlumni call to complete.")
        
        // Perform the asynchronous call.
        articleListVM!.fetchArticleList() { response in
            // Save the response.
            result = response
            // Fulfill the expectation.
            expectation.fulfill()
        }
        
        // Wait for expectations for a maximum of 2 seconds.
        waitForExpectations(timeout: 6) { error in
            XCTAssertNil(error)
            switch result {
            case .success(let resultFetched):
                XCTAssertEqual(resultFetched, true)
            case .failure,
                    .none:
                XCTFail()
            }
        }
    }
    
}

class ArticleAppTests: XCTestCase {
    
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
