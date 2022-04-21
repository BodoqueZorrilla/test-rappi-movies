//
//  MovieDetailTests.swift
//  test-rappi-moviesTests
//
//  Created by Sergio Zorrilla Arellano on 20/04/22.
//

import XCTest
@testable import test_rappi_movies

class MovieDetailTests: XCTestCase {

    private var sut: MovieDetailInteractor!

    override func setUp() {
        sut = MovieDetailInteractor()
    }

    func testGetMovies() {
        //GIVEN

        let workerSpy = GetMovieWorkerSpySuccess()
        let getMoviesSpy = GetMoviePresemterSpy()
        let response = ReponseDetailMovie(id: 333, adult: false, backdropPath: "urlimage", belongsToCollection: BelongsToCollection(id: 3, name: "colecion", posterPath: "pathstrng", backdropPath: "pathstirng"), budget: 333333, genres: [Genres(id: 3, name: "supermane")], homepage: "True", imdbId: "bodoque", originalLanguage: "MX", originalTitle: "Bdooque the super hero", overview: "making tests to get the job", popularity: 33, posterPath: "dkdk", productionCompanies: [ProductionCompanies(id: 3, name: "name", logoPath: "logopaht", originCountry: "MX")], productionCountries: [ProductionCountries(name: "Name", iso31: "iso9001")], releaseDate: "1991-10-04", revenue: 4333, runtime: 333, spokenLanguages: [SpokenLanguages(englishName: "MX", iso639: "MX", name: "Spanish")], status: "active", tagline: "tagñoe", title: "toeñte", video: true, voteAverage: 33.3, voteCount: 333)
        sut.worker = workerSpy
        sut.presenter = getMoviesSpy
        // WHEN
        sut.fetchMovieDetail()
        sut.fetchVideo()
        
        // THEN
        getMoviesSpy.presentMovieDetail = true
        getMoviesSpy.presentMovieDetailResponse = MovieDetail.FetchDetailMovie.Response(reponseDetailMovie: response)
        getMoviesSpy.presentVideo = true
        getMoviesSpy.presentVideoResponse = "key"

        workerSpy.getMovieDetail(movieId: 33) { response in
            XCTAssertTrue(getMoviesSpy.presentMovieDetail)
            XCTAssertEqual(getMoviesSpy.presentMovieDetailResponse?.reponseDetailMovie?.title, response.reponseDetailMovie?.title)
            XCTAssertNotNil(getMoviesSpy.presentMovieDetailResponse)
        }
    }

}

class GetMovieWorkerSpySuccess: MovieDetailWorkerInterface {
    func getMovieDetail(movieId: Int, completion: @escaping (MovieDetail.FetchDetailMovie.Response) -> Void) {
        let response = ReponseDetailMovie(id: 333, adult: false, backdropPath: "urlimage", belongsToCollection: BelongsToCollection(id: 3, name: "colecion", posterPath: "pathstrng", backdropPath: "pathstirng"), budget: 333333, genres: [Genres(id: 3, name: "supermane")], homepage: "True", imdbId: "bodoque", originalLanguage: "MX", originalTitle: "Bdooque the super hero", overview: "making tests to get the job", popularity: 33, posterPath: "dkdk", productionCompanies: [ProductionCompanies(id: 3, name: "name", logoPath: "logopaht", originCountry: "MX")], productionCountries: [ProductionCountries(name: "Name", iso31: "iso9001")], releaseDate: "1991-10-04", revenue: 4333, runtime: 333, spokenLanguages: [SpokenLanguages(englishName: "MX", iso639: "MX", name: "Spanish")], status: "active", tagline: "tagñoe", title: "toeñte", video: true, voteAverage: 33.3, voteCount: 333)
        let responseData = MovieDetail.FetchDetailMovie.Response(reponseDetailMovie: response)
        completion(responseData)
    }
    
    func getMovieDetailOffline(movieId: Int, completion: @escaping (MovieDetail.FetchDetailMovie.Response) -> Void) {
        let response = ReponseDetailMovie(id: 333, adult: false, backdropPath: "urlimage", belongsToCollection: BelongsToCollection(id: 3, name: "colecion", posterPath: "pathstrng", backdropPath: "pathstirng"), budget: 333333, genres: [Genres(id: 3, name: "supermane")], homepage: "True", imdbId: "bodoque", originalLanguage: "MX", originalTitle: "Bdooque the super hero", overview: "making tests to get the job", popularity: 33, posterPath: "dkdk", productionCompanies: [ProductionCompanies(id: 3, name: "name", logoPath: "logopaht", originCountry: "MX")], productionCountries: [ProductionCountries(name: "Name", iso31: "iso9001")], releaseDate: "1991-10-04", revenue: 4333, runtime: 333, spokenLanguages: [SpokenLanguages(englishName: "MX", iso639: "MX", name: "Spanish")], status: "active", tagline: "tagñoe", title: "toeñte", video: true, voteAverage: 33.3, voteCount: 333)
        let responseData = MovieDetail.FetchDetailMovie.Response(reponseDetailMovie: response)
        completion(responseData)
    }
    
    func getMovieVideo(movieId: Int, completion: @escaping (MovieVideo) -> Void) {
        let response = MovieVideo(id: movieId, results: [ResultVideo(iso6391: "", iso31661: "", name: "matrix", key: "bodoque", site: "www.google.com", size: 4, type: "video", official: true, publishedAt: "sadf", id: "3333")])
        completion(response)
    }
}

class GetMoviePresemterSpy: MovieDetailPresentationLogic {

    var presentMovieDetail = false
    var presentMovieDetailResponse: MovieDetail.FetchDetailMovie.Response?
    var presentVideo = false
    var presentVideoResponse: String?


    func presentDetailMovieScene(response: MovieDetail.FetchDetailMovie.Response) {
        presentMovieDetail = true
        presentMovieDetailResponse = response
    }
    
    func presentVideo(keyVideo: String) {
        presentVideo = true
        presentVideoResponse = keyVideo
    }
}

