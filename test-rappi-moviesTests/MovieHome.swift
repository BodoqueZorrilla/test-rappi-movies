//
//  MovieHome.swift
//  test-rappi-moviesTests
//
//  Created by Sergio Zorrilla Arellano on 20/04/22.
//

import XCTest
@testable import test_rappi_movies

class MovieHome: XCTestCase {

    private var sut: HomeInteractor!

    override func setUp() {
        sut = HomeInteractor()
    }

    func testGetMovies() {
        //GIVEN
        let request = Home.FetchMovieScene.Request(type: .popular,
                                                   completeUrl: "movie/popular")
        let querysearch = "Matr"
        let sectionMovie = Home.SectionsTitle.popular.rawValue
        let workerSpy = GetMoviesWorkerSpySuccess()
        let getMoviesSpy = GetMoviesPresemterSpy()
        sut.worker = workerSpy
        sut.presenter = getMoviesSpy
        // WHEN
        sut.getMovies(request: request)
        sut.getMoviesSearch(query: querysearch, isOnline: true)
        sut.getMoviesSearch(query: querysearch, isOnline: false)
        sut.getMoviesOffline(section: sectionMovie)
        
        // THEN
        getMoviesSpy.presentMovies = true
        getMoviesSpy.presentMoviesResponse = [ResultsMovies(adult: false, backdropPath: "", genreIds: [35,80], id: 33333, originalLanguage: "en", originalTitle: "Matrix", overview: "Description of the movie", popularity: 6234.63, posterPath: "", releaseDate: "2021-05-26", title: "Cruella", video: false, voteAverage: 8.8, voteCount: 2602)]
        getMoviesSpy.presentMoviesSearch = true
        getMoviesSpy.presentMoviesSearchResponse = [ResultsMovies(adult: false, backdropPath: "", genreIds: [35,80], id: 33333, originalLanguage: "en", originalTitle: "Matrix Search", overview: "Description of the movie", popularity: 6234.63, posterPath: "", releaseDate: "2021-05-26", title: "Cruella", video: false, voteAverage: 8.8, voteCount: 2602)]
        workerSpy.getMovies(completeUrl: "movie/popular") { response in
            XCTAssertTrue(getMoviesSpy.presentMovies)
            XCTAssertEqual(getMoviesSpy.presentMoviesResponse?.count, response.count)
            XCTAssertNotNil(getMoviesSpy.presentMoviesResponse)
        }
    }

}

class GetMoviesWorkerSpySuccess: HomeWorkerInterface {
    func getMovies(completeUrl: String, completion: @escaping ([ResultsMovies]) -> Void) {
        let dataResponse = [ResultsMovies(adult: false, backdropPath: "", genreIds: [35,80], id: 33333, originalLanguage: "en", originalTitle: "Matrix", overview: "Description of the movie", popularity: 6234.63, posterPath: "", releaseDate: "2021-05-26", title: "Cruella", video: false, voteAverage: 8.8, voteCount: 2602)]
        completion(dataResponse)
    }
    
    func getMoviesSearch(completeUrl: String, completion: @escaping ([ResultsMovies]) -> Void) {
        let dataResponse = [ResultsMovies(adult: false, backdropPath: "", genreIds: [35,80], id: 33333, originalLanguage: "en", originalTitle: "Matrix Search", overview: "Description of the movie", popularity: 6234.63, posterPath: "", releaseDate: "2021-05-26", title: "Cruella", video: false, voteAverage: 8.8, voteCount: 2602)]
        completion(dataResponse)
    }
    
    func getMoviesSearchOffline(query: String, completion: @escaping ([ResultsMovies]) -> Void) {
        let dataResponse = [ResultsMovies(adult: false, backdropPath: "", genreIds: [35,80], id: 33333, originalLanguage: "en", originalTitle: "Matrix Search Offline", overview: "Description of the movie", popularity: 6234.63, posterPath: "", releaseDate: "2021-05-26", title: "Cruella", video: false, voteAverage: 8.8, voteCount: 2602)]
        completion(dataResponse)
    }
    
    func getMoviesOffline(section: String, completion: @escaping ([ResultsMovies]) -> Void) {
        let dataResponse = [ResultsMovies(adult: false, backdropPath: "", genreIds: [35,80], id: 33333, originalLanguage: "en", originalTitle: "Matrix Offline", overview: "Description of the movie", popularity: 6234.63, posterPath: "", releaseDate: "2021-05-26", title: "Cruella", video: false, voteAverage: 8.8, voteCount: 2602)]
        completion(dataResponse)
    }
}

class GetMoviesPresemterSpy: HomePresentationLogic {

    
    var presentMovies = false
    var presentMoviesResponse: [ResultsMovies]?
    var presentMoviesSearch = false
    var presentMoviesSearchResponse: [ResultsMovies]?

    func presentMovies(section: Home.SectionsTitle, response: [ResultsMovies]) {
        presentMovies = true
        presentMoviesResponse = response
    }
    
    func presentMoviesSearch(response: [ResultsMovies]) {
        presentMoviesSearch = true
        presentMoviesSearchResponse = response
    }
}
