//
//  MovieDetailsRouterTests.swift
//  MovieAppTests
//
//  Created by Cengizhan Tomak on 31.07.2023.
//

import XCTest
@testable import MovieApp

class MovieDetailsRouterTests: XCTestCase {
    
    var sut: MovieDetailsRouter!
    var mockNavigationController: MockNavigationController!
    
    override func setUp() {
        super.setUp()
        
        sut = MovieDetailsRouter()
        
        let viewController = MovieDetailsViewController()
        mockNavigationController = MockNavigationController(rootViewController: viewController)
        
        sut.viewController = viewController
        sut.dataStore = MovieDetailsInteractor()
    }
    
    override func tearDown() {
        sut = nil
        mockNavigationController = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    func test_routeToCastCrew() {
        // When
        sut.routeToCastCrew()
        
        // Then
        XCTAssertTrue(mockNavigationController.pushedViewController is CastCrewViewController)
    }
    
    func test_routeToPhotos() {
        // When
        sut.routeToPhotos()
        
        // Then
        XCTAssertTrue(mockNavigationController.pushedViewController is PhotosViewController)
    }
    
    func test_routeToVideos() {
        // When
        sut.routeToVideos()
        
        // Then
        XCTAssertTrue(mockNavigationController.pushedViewController is VideosViewController)
    }
    
    func test_routeToGetTicket() {
        // When
        sut.routeToGetTicket()
        
        // Then
        XCTAssertTrue(mockNavigationController.pushedViewController is GetTicketViewController)
    }
    
    func test_routeToWatchList() {
        // When
        sut.routeToWatchList()
        
        // Then
        XCTAssertTrue(mockNavigationController.pushedViewController is WatchlistViewController)
    }
}

extension MovieDetailsRouterTests {
    
    // MARK: - Mock NavigationController
    class MockNavigationController: UINavigationController {
        var pushedViewController: UIViewController?
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            pushedViewController = viewController
            super.pushViewController(viewController, animated: animated)
        }
    }
}
