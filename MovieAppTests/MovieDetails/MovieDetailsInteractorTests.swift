//
//  MovieDetailsInteractorTests.swift
//  MovieAppTests
//
//  Created by Cengizhan Tomak on 30.07.2023.
//

import XCTest
@testable import MovieApp

class MovieDetailsInteractorTests: XCTestCase {
    
    var sut: MovieDetailsInteractor!
    var mockWorker: MockMovieDetailsWorker!
    var mockPresenter: MockMovieDetailsPresenter!
    
    override func setUp() {
        super.setUp()
        
        sut = MovieDetailsInteractor()
        mockWorker = MockMovieDetailsWorker()
        mockPresenter = MockMovieDetailsPresenter()
        sut.worker = mockWorker
        sut.presenter = mockPresenter
        sut.selectedMovieID = 1
    }
    
    override func tearDown() {
        sut = nil
        mockWorker = nil
        mockPresenter = nil
        super.tearDown()
    }
    
    // MARK: - Sample Data
    func sampleMovieResponse() -> MoviesResponse.Movie {
        return MoviesResponse.Movie(title: "Title",
                                    releaseDate: "Date",
                                    posterPath: "Path",
                                    overview: "Overview",
                                    id: 1,
                                    vote: 5.0,
                                    runtime: 120,
                                    genres: [MoviesResponse.Genres(name: "Genre")])
    }
    
    func sampleMovieCast() -> [MoviesResponse.Cast] {
        return [MoviesResponse.Cast(profilePhoto: "path", name: "Name", character: "Character")]
    }
    
    func sampleMovieImages() -> [MoviesResponse.Images] {
        return [MoviesResponse.Images(images: "path")]
    }
    
    // MARK: - Test Cases
    func test_fetchMovieDetails() {
        // Given
        
        // When
        sut.fetchMovieDetails()
        
        // Then
        XCTAssertTrue(mockWorker.getMovieDetailsCalled)
    }
    
    func test_fetchMovieCast() {
        // Given
        mockWorker.getMovieCreditsResponse = .success(MoviesResponse.Credits(cast: sampleMovieCast()))
        
        // When
        sut.fetchMovieCast(details: sampleMovieResponse())
        
        // Then
        XCTAssertTrue(mockWorker.getMovieCreditsCalled)
    }
    
    func test_fetchMovieImages() {
        // Given
        mockWorker.getMovieImagesResponse = .success(MoviesResponse.Backdrops(backdrops: sampleMovieImages()))
        
        // When
        sut.fetchmovieImages(details: sampleMovieResponse(), cast: sampleMovieCast())
        
        // Then
        XCTAssertTrue(mockWorker.getMovieImagesCalled)
    }
    
    func test_fetchWatchList() {
        // Given
        mockWorker.getWatchListResponse = .success(MoviesResponse.NowPlaying(results: [sampleMovieResponse()]))
        
        // When
        sut.fetchWatchList(details: sampleMovieResponse(), cast: sampleMovieCast(), images: sampleMovieImages())
        
        // Then
        XCTAssertTrue(mockWorker.getWatchListCalled)
    }
    
    func test_postToAddWatchlist() {
        // Given
        mockWorker.postToWatchlistResponse = .success(MoviesResponse.Watchlist(statusCode: 1, statusMessage: "Message"))
        
        // When
        sut.postToAddWatchlist()
        
        // Then
        XCTAssertTrue(mockWorker.postToAddWatchlistCalled)
    }
    
    func test_postToRemoveWatchlist() {
        // Given
        mockWorker.postToWatchlist2Response = .success(MoviesResponse.Watchlist(statusCode: 1, statusMessage: "Message"))
        
        // When
        sut.postToRemoveWatchlist()
        
        // Then
        XCTAssertTrue(mockWorker.postToRemoveWatchlistCalled)
    }
    
    func test_viewAllCast() {
        // Given
        sut.allCast = [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedCast(name: "Name", character: "Character", profilePhotoPath: "Path")]
        
        // When
        sut.viewAllCast(with: [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedCast(name: "Name", character: "Character", profilePhotoPath: "Path")])
        
        // Then
        XCTAssertEqual(mockPresenter.presentAllCastCalled, true)
    }
    
    func test_viewAllPhotos() {
        // Given
        sut.allPhotos = [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedImages(images: "Path")]
        
        // When
        sut.viewAllPhotos(with: [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedImages(images: "Path")])
        
        // Then
        XCTAssertEqual(mockPresenter.presentAllPhotosCalled, true)
    }
}

extension MovieDetailsInteractorTests {
    
    // MARK: - Mock Worker
    final class MockMovieDetailsWorker: MovieDetailsWorkingLogic {
        var getMovieDetailsCalled = false
        var postToAddWatchlistCalled = false
        var getMovieCreditsCalled = false
        var getMovieImagesCalled = false
        var getWatchListCalled = false
        var postToRemoveWatchlistCalled = false
        
        // Your mock responses
        var getMovieCreditsResponse: Result<MoviesResponse.Credits, RequestError>?
        var getMovieImagesResponse: Result<MoviesResponse.Backdrops, RequestError>?
        var getWatchListResponse: Result<MoviesResponse.NowPlaying, RequestError>?
        var postToWatchlistResponse: Result<MoviesResponse.Watchlist, RequestError>?
        var postToWatchlist2Response: Result<MoviesResponse.Watchlist, RequestError>?
        
        func getMovieCredits(id: Int, _ completion: @escaping (Result<MoviesResponse.Credits, RequestError>) -> Void) {
            getMovieCreditsCalled = true
            if let response = getMovieCreditsResponse {
                completion(response)
            }
        }
        
        func getMovieDetails(id: Int, _ completion: @escaping (Result<MoviesResponse.Movie, RequestError>) -> Void) {
            getMovieDetailsCalled = true
        }
        
        func getMovieImages(id: Int, _ completion: @escaping (Result<MoviesResponse.Backdrops, RequestError>) -> Void) {
            getMovieImagesCalled = true
            if let response = getMovieImagesResponse {
                completion(response)
            }
        }
        
        func postToAddWatchlist(movieId: Int, _ completion: @escaping (Result<MoviesResponse.Watchlist, RequestError>) -> Void) {
            postToAddWatchlistCalled = true
            if let response = postToWatchlistResponse {
                completion(response)
            }
        }
        
        func getWatchList(_ completion: @escaping (Result<MoviesResponse.NowPlaying, RequestError>) -> Void) {
            getWatchListCalled = true
            if let response = getWatchListResponse {
                completion(response)
            }
        }
        
        func postToRemoveWatchlist(movieId: Int, _ completion: @escaping (Result<MoviesResponse.Watchlist, RequestError>) -> Void) {
            postToRemoveWatchlistCalled = true
            if let response = postToWatchlist2Response {
                completion(response)
            }
        }
    }
    
    // MARK: - Mock Presenter
    final class MockMovieDetailsPresenter: MovieDetailsPresentationLogic {
        var presentAllCastCalled = false
        var presentAllPhotosCalled = false
        var presentDetailsCalled = false
        var presentGetTicketCalled = false
        
        func presentAllCast() {
            presentAllCastCalled = true
        }
        
        func presentAllPhotos() {
            presentAllPhotosCalled = true
        }
        
        func presentDetails(response: MovieApp.MovieDetailsModels.FetchMovieDetails.Response) {
            presentDetailsCalled = true
        }
        
        func presentGetTicket() {
            presentGetTicketCalled = true
        }
    }
}
