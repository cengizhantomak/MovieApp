//
//  MovieDetailsPresenterTests.swift
//  MovieAppTests
//
//  Created by Cengizhan Tomak on 31.07.2023.
//

import XCTest
@testable import MovieApp

class MovieDetailsPresenterTest: XCTestCase {
    
    var sut: MovieDetailsPresenter!
    var mockVC: MockMovieDetailsViewController!
    
    override func setUp() {
        super.setUp()
        
        sut = MovieDetailsPresenter()
        mockVC = MockMovieDetailsViewController()
        sut.viewController = mockVC
    }
    
    override func tearDown() {
        sut = nil
        mockVC = nil
        super.tearDown()
    }
    
    // MARK: - Sample Data
    
    func sampleResponse() -> MovieDetailsModels.FetchMovieDetails.Response {
        let cast = MoviesResponse.Cast(
            profilePhoto: "ProfilePhoto",
            name: "Name",
            character: "Character"
        )
        
        let movie = MoviesResponse.Movie(
            title: "Title",
            releaseDate: "Test",
            posterPath: "PosterPath",
            overview: "Overview",
            id: 1,
            vote: 7.5,
            runtime: 120,
            genres: nil
        )
        
        let image = MoviesResponse.Images(images: "Images")
        
        return MovieDetailsModels.FetchMovieDetails.Response(
            cast: [cast],
            details: movie,
            images: [image],
            watchList: [movie]
        )
    }
    
    // MARK: - Test Cases
    
    func test_PresentDetails() {
        // Given
        let response = sampleResponse()
        
        // When
        sut.presentDetails(response: response)
        
        
        let expectation = XCTestExpectation(description: "Present details expectation") // Create an expectation
        DispatchQueue.main.async {
            
            expectation.fulfill() // Fulfill the expectation since the test has been completed successfully
        }
        
        wait(for: [expectation], timeout: 1.0) // This will wait until the expectation is fulfilled, or a timeout occurs.
        
        // Then
        XCTAssertTrue(mockVC.isFetchedDetailsCalled)
        XCTAssertEqual(mockVC.displayedDetails?.title, response.details.title)
    }
    
    func test_PresentAllCast() {
        // When
        sut.presentAllCast()
        
        // Then
        XCTAssertTrue(mockVC.isDisplayCastCalled)
    }
    
    func test_PresentAllPhotos() {
        // When
        sut.presentAllPhotos()
        
        // Then
        XCTAssertTrue(mockVC.isDisplayPhotosCalled)
    }
    
    func test_PresentGetTicket() {
        // When
        sut.presentGetTicket()
        
        // Then
        XCTAssertTrue(mockVC.isDisplayGetTicketCalled)
    }
}

// MARK: - Mock VC

final class MockMovieDetailsViewController: MovieDetailsDisplayLogic {
    var isFetchedDetailsCalled = false
    var isDisplayCastCalled = false
    var isDisplayPhotosCalled = false
    var isDisplayGetTicketCalled = false
    
    var displayedDetails: MovieDetailsModels.FetchMovieDetails.ViewModel?
    
    func displayFetchedDetails(viewModel: MovieDetailsModels.FetchMovieDetails.ViewModel) {
        displayedDetails = viewModel
        isFetchedDetailsCalled = true
    }
    
    func displayCast() {
        isDisplayCastCalled = true
    }
    
    func displayPhotos() {
        isDisplayPhotosCalled = true
    }
    
    func displayGetTicket() {
        isDisplayGetTicketCalled = true
    }
}
