//
//  MovieDetailsViewControllerTests.swift
//  MovieAppTests
//
//  Created by Cengizhan Tomak on 30.07.2023.
//

import XCTest
@testable import MovieApp

final class MovieDetailsViewControllerTests: XCTestCase {
    
    var sut: MovieDetailsViewController!
    var mockInteractor: MockMovieDetailsInteractor!
    var mockRouter: MockMovieDetailsRouter!
    var testViewModel: MovieDetailsModels.FetchMovieDetails.ViewModel!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "MovieDetails", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "MovieDetailsViewController") as? MovieDetailsViewController
        sut?.loadViewIfNeeded()
        
        mockInteractor = MockMovieDetailsInteractor()
        mockRouter = MockMovieDetailsRouter()
        sut.interactor = mockInteractor
        sut.router = mockRouter
        
        testViewModel = sampleViewModel()
    }
    
    override func tearDown() {
        sut = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }
    
    // MARK: - Sample Data
    
    func sampleViewModel() -> MovieDetailsModels.FetchMovieDetails.ViewModel {
        return MovieDetailsModels.FetchMovieDetails.ViewModel(displayedCast: [],
                                                              displayedImages: [],
                                                              displayedWatchList: [],
                                                              title: "Test Movie",
                                                              overview: "Test overview",
                                                              genres: "Action",
                                                              runtime: 120,
                                                              vote: 8.0,
                                                              posterPhotoPath: "testPath",
                                                              id: 0)
    }
    
    // MARK: - Test Cases
    
    func test_viewDidLoad() {
        // Given
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockInteractor.fetchMovieDetailsCalled)
    }
    
    func test_displayFetchedDetails() {
        // Given
        
        // When
        sut?.displayFetchedDetails(viewModel: testViewModel)
        
        // Then
        XCTAssertEqual(sut?.titleLabel.text, "Test Movie")
        XCTAssertEqual(sut?.genreLabel.text, "Action")
    }
    
    func test_GetTicketButtonTapped() {
        // Given
        sut.displayedDetails = testViewModel
        
        // When
        sut.getTicketButtonTapped(UIButton())
        
        // Then
        XCTAssertTrue(mockInteractor.selectedMovieGetTicketCalled)
    }
    
    func test_viewAllCastButtonCallsInteractorMethod() {
        // Given
        sut.displayedDetails = testViewModel
        
        // When
        sut.viewAllCastButton()
        
        // Then
        XCTAssertTrue(mockInteractor.viewAllCastCalled)
    }
    
    func test_viewAllPhotosButtonCallsInteractorMethod() {
        // Given
        sut.displayedDetails = testViewModel
        
        // When
        sut.viewAllPhotosButton()
        
        // Then
        XCTAssertTrue(mockInteractor.viewAllPhotosCalled)
    }
    
    func test_videosButtonTapped() {
        // Given
        
        // When
        sut.videosButtonTapped(UIButton())
        
        // Then
        XCTAssertTrue(mockRouter.routeToVideosCalled)
    }
    
    func test_onMovieAddedToWatchlist() {
        // Given
        let expectation = self.expectation(description: "Wait for main queue")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        let notification = Notification(name: .movieAddedToWatchlist)
        
        // When
        sut.onMovieAddedToWatchlist(notification)
        
        self.waitForExpectations(timeout: 1, handler: nil)
        
        // Then
        XCTAssertEqual(sut.addRemoveWatchlistButton.title(for: .normal), "Remove Watchlist")
        XCTAssertEqual(sut.addRemoveWatchlistButton.backgroundColor, UIColor(named: "47CFFF"))
    }
    
    func test_onMovieDeletedToWatchlist() {
        // Given
        let notification = Notification(name: .movieDeletedToWatchlist)
        
        // When
        sut.onMovieDeletedToWatchlist(notification)
        
        // Then
        XCTAssertEqual(sut.addRemoveWatchlistButton.title(for: .normal), "Add Watchlist")
        XCTAssertEqual(sut.addRemoveWatchlistButton.backgroundColor, UIColor(named: "buttonRed"))
    }
    
    func test_displayCast() {
        // Given
        
        // When
        sut.displayCast()
        
        // Then
        XCTAssertTrue(mockRouter.routeToCastCrewCalled)
    }
    
    func test_displayPhotos() {
        // Given
        
        // When
        sut.displayPhotos()
        
        // Then
        XCTAssertTrue(mockRouter.routeToPhotosCalled)
    }
    
    func test_displayGetTicket() {
        // Given
        
        // When
        sut.displayGetTicket()
        
        // Then
        XCTAssertTrue(mockRouter.routeToGetTicketCalled)
    }
    
    func test_numberOfSections() {
        // When
        let numberOfSections = sut.numberOfSections(in: sut.tableView)
        
        // Then
        XCTAssertEqual(numberOfSections, 3)
    }
    
    func test_numberOfRowsInSection_synopsis() {
        // Given
        sut.displayedDetails = testViewModel
        
        // When
        let numberOfRows = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        
        // Then
        XCTAssertEqual(numberOfRows, 1)
    }
    
    func test_numberOfRowsInSection_cast() {
        // Given
        sut.displayedDetails = testViewModel
        
        // When
        let numberOfRows = sut.tableView(sut.tableView, numberOfRowsInSection: 1)
        
        // Then
        XCTAssertEqual(numberOfRows, 0)
    }
    
    func test_numberOfRowsInSection_photos() {
        // Given
        sut.displayedDetails = testViewModel
        
        // When
        let numberOfRows = sut.tableView(sut.tableView, numberOfRowsInSection: 2)
        
        // Then
        XCTAssertEqual(numberOfRows, 0)
    }
    
    func test_cellForRowAt_synopsis() {
        // Given
        sut.displayedDetails = testViewModel
        
        // When
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertTrue(cell is SynopsisTableViewCell)
    }
    
    func test_cellForRowAt_photos() {
        // Given
        sut.displayedDetails = testViewModel
        
        // When
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 2))
        
        // Then
        XCTAssertTrue(cell is UITableViewCell)
    }
    
    func test_heightForHeaderInSection() {
        // When
        let headerHeight = sut.tableView(sut.tableView, heightForHeaderInSection: 0)
        
        // Then
        XCTAssertEqual(headerHeight, 30)
    }
    
    func test_viewForHeaderInSection() {
        // Given
        
        // When
        let headerView = sut.tableView(sut.tableView, viewForHeaderInSection: 0)
        
        // Then
        XCTAssertTrue(headerView is SectionHeader)
    }
    
    func test_collectionView_numberOfItemsInSection() {
        // Given
        sut.displayedDetails = testViewModel
        
        // When
        let numberOfItems = sut.collectionView(sut.collectionView, numberOfItemsInSection: 0)
        
        // Then
        XCTAssertEqual(numberOfItems, 0)
    }
    
    func test_collectionView_sizeForItemAt() {
        // Given
        
        // When
        let size = sut.collectionView(sut.collectionView, layout: UICollectionViewFlowLayout(), sizeForItemAt: IndexPath(item: 0, section: 0))
        
        // Then
        XCTAssertEqual(size.width, (sut.collectionView.frame.width - 50) / 3)
        XCTAssertEqual(size.height, sut.collectionView.frame.height)
    }
    
    func test_collectionView_insetForSectionAt() {
        // Given
        
        // When
        let insets = sut.collectionView(sut.collectionView, layout: UICollectionViewFlowLayout(), insetForSectionAt: 0)
        
        // Then
        XCTAssertEqual(insets, UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))
    }
    
    func test_collectionView_minimumLineSpacingForSectionAt() {
        // Given
        
        // When
        let spacing = sut.collectionView(sut.collectionView, layout: UICollectionViewFlowLayout(), minimumLineSpacingForSectionAt: 0)
        
        // Then
        XCTAssertEqual(spacing, CGFloat(5))
    }
}

extension MovieDetailsViewControllerTests {
    
    // MARK: - Mock Interactor
    
    final class MockMovieDetailsInteractor: MovieDetailsBusinessLogic {
        
        var fetchMovieDetailsCalled = false
        var viewAllCastCalled = false
        var viewAllPhotosCalled = false
        var postToAddWatchlistCalled = false
        var postToRemoveWatchlistCalled = false
        var selectedMovieGetTicketCalled = false
        var formatRuntimeCalled = false
        var toggleWatchlistStatusCalled = false
        
        func fetchMovieDetails() {
            fetchMovieDetailsCalled = true
        }
        
        func viewAllCast(with: [MovieApp.MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedCast]) {
            viewAllCastCalled = true
        }
        
        func viewAllPhotos(with: [MovieApp.MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedImages]) {
            viewAllPhotosCalled = true
        }
        
        func postToAddWatchlist() {
            postToAddWatchlistCalled = true
        }
        
        func postToRemoveWatchlist() {
            postToRemoveWatchlistCalled = true
        }
        
        func selectedMovieGetTicket(movie: String, image: String) {
            selectedMovieGetTicketCalled = true
        }
        
        func formatRuntime(_ totalMinutes: Int) -> String {
            formatRuntimeCalled = true
            return "Dummy Runtime"
        }
        
        func toggleWatchlistStatus(_ details: MovieApp.MovieDetailsModels.FetchMovieDetails.ViewModel?) -> MovieApp.MovieDetailsModels.FetchMovieDetails.ViewModel? {
            toggleWatchlistStatusCalled = true
            return MovieDetailsModels.FetchMovieDetails.ViewModel(displayedCast: [],
                                                                  displayedImages: [],
                                                                  displayedWatchList: [],
                                                                  title: "Test Movie",
                                                                  overview: "Test overview",
                                                                  genres: "Action",
                                                                  runtime: 120,
                                                                  vote: 8.0,
                                                                  posterPhotoPath: "testPath",
                                                                  id: 0)
        }
    }
    
    // MARK: - Mock Router
    
    final class MockMovieDetailsRouter: MovieDetailsRoutingLogic, MovieDetailsDataPassing {
        var dataStore: MovieApp.MovieDetailsDataStore?
        
        var routeToPhotosCalled = false
        var routeToCastCrewCalled = false
        var routeToGetTicketCalled = false
        var routeToWatchListCalled = false
        var routeToVideosCalled = false
        
        func routeToPhotos() {
            routeToPhotosCalled = true
        }
        
        func routeToCastCrew() {
            routeToCastCrewCalled = true
        }
        
        func routeToGetTicket() {
            routeToGetTicketCalled = true
        }
        
        func routeToWatchList() {
            routeToWatchListCalled = true
        }
        
        func routeToVideos() {
            routeToVideosCalled = true
        }
    }
}
