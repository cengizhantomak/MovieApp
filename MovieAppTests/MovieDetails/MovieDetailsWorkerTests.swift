//
//  MovieDetailsWorkerTests.swift
//  MovieAppTests
//
//  Created by Cengizhan Tomak on 31.07.2023.
//

import XCTest
@testable import MovieApp

class MovieDetailsWorkerTests: XCTestCase {
    
    var sut: MovieDetailsWorker!
    
    override func setUp() {
        super.setUp()
        
        sut = MovieDetailsWorker()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    func test_getMovieCredits() {
        let expectation = self.expectation(description: "Get Movie Credits")
        
        sut.getMovieCredits(id: 123) { result in
            switch result {
            case .success(let credits):
                XCTAssertNotNil(credits, "Credits should not be nil")
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_getMovieDetails() {
        let expectation = self.expectation(description: "Get Movie Details")
        
        sut.getMovieDetails(id: 123) { result in
            switch result {
            case .success(let movie):
                XCTAssertNotNil(movie, "Movie should not be nil")
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_getMovieImages() {
        let expectation = self.expectation(description: "Get Movie Images")
        
        sut.getMovieImages(id: 123) { result in
            switch result {
            case .success(let backdrops):
                XCTAssertNotNil(backdrops, "Backdrops should not be nil")
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_postToAddWatchlist() {
        let expectation = self.expectation(description: "Post to Watchlist")
        
        sut.postToAddWatchlist(movieId: 123) { result in
            switch result {
            case .success(let watchlist):
                XCTAssertNotNil(watchlist, "Watchlist should not be nil")
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_getWatchList() {
        let expectation = self.expectation(description: "Get Watchlist")
        
        sut.getWatchList { result in
            switch result {
            case .success(let nowPlaying):
                XCTAssertNotNil(nowPlaying, "Now playing list should not be nil")
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_postToRemoveWatchlist() {
        let expectation = self.expectation(description: "Post to Watchlist 2")
        
        sut.postToRemoveWatchlist(movieId: 123) { result in
            switch result {
            case .success(let watchlist):
                XCTAssertNotNil(watchlist, "Watchlist 2 should not be nil")
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
