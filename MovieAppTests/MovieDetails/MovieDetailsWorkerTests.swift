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
    var mockClient: MockHTTPClient!
    
    override func setUp() {
        super.setUp()
        mockClient = MockHTTPClient()
        sut = MovieDetailsWorker(httpClient: mockClient)
    }
    
    override func tearDown() {
        sut = nil
        mockClient = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    func test_getMovieCredits() {
        let expectation = self.expectation(description: "Get Movie Credits")
        
        mockClient.response = MoviesResponse.Credits(cast: [])
        
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
        
        mockClient.response = MoviesResponse.Movie(title: "Title",
                                                   releaseDate: "Date",
                                                   posterPath: "Path",
                                                   overview: "Overview",
                                                   id: 1,
                                                   vote: 5.0,
                                                   runtime: 120,
                                                   genres: [MoviesResponse.Genres(name: "Genre")])
        
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
        
        mockClient.response = MoviesResponse.Images(images: "path")
        
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
        
        mockClient.response = MoviesResponse.Watchlist(statusCode: 1, statusMessage: "Message")
        
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
        
        mockClient.response = MoviesResponse.NowPlaying(results: [])
        
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
        
        mockClient.response = MoviesResponse.Watchlist(statusCode: 1, statusMessage: "Message")
        
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

extension MovieDetailsWorkerTests {
    
    // MARK: - Mock Client
    final class MockHTTPClient: HTTPClient {
        var shouldReturnError = false
        var response: Decodable?
        
        public init() { }
        
        public func sendRequest<T: Decodable>(endpoint: Endpoint,
                                              responseModel: T.Type,
                                              completion: @escaping (Result<T, RequestError>) -> Void) {
            if shouldReturnError {
                completion(.failure(.decode))
            } else {
                guard let response = response as? T else {
                    return completion(.failure(.decode))
                }
                completion(.success(response))
            }
        }
    }
}
