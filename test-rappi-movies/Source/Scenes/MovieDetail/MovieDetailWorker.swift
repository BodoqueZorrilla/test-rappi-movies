//
//  MovieDetailWorker.swift
//  test-rappi-movies
//
//  Created by Sergio Zorrilla Arellano on 15/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the iOS team Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//

import UIKit
import RxSwift

protocol MovieDetailWorkerInterface {
    func getMovieDetail(movieId: Int, completion: @escaping (MovieDetail.FetchDetailMovie.Response) -> Void)
    func getMovieDetailOffline(movieId: Int, completion: @escaping (MovieDetail.FetchDetailMovie.Response) -> Void)
    func getMovieVideo(movieId: Int, completion: @escaping (MovieVideo) -> Void)
}

class MovieDetailWorker: MovieDetailWorkerInterface {
    private let disposeBag = DisposeBag()

    func getMovieDetail(movieId: Int, completion: @escaping (MovieDetail.FetchDetailMovie.Response) -> Void) {
        let request =  APIRequest()
        request.completeUrl = "movie/\(movieId)"
        let result : Observable<ReponseDetailMovie> = APIService.apiCalling.getMovieDetail(apiRequest: request)
        result.subscribe(
            onNext: { result in
                let response = MovieDetail.FetchDetailMovie.Response(reponseDetailMovie: result)
                completion(response)
            },
            onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }

    func getMovieDetailOffline(movieId: Int, completion: @escaping (MovieDetail.FetchDetailMovie.Response) -> Void) {
        let movieCache = CoreDataMovieManager.shared.getMovie(movieId)
        let detailMovie = ReponseDetailMovie(id: Int(movieCache.id), adult: false, backdropPath: movieCache.image, belongsToCollection: BelongsToCollection(), budget: 333, genres: [Genres](), homepage: "", imdbId: "iddbId", originalLanguage: "", originalTitle: movieCache.title, overview: movieCache.overview, popularity: movieCache.voteAverage, posterPath: movieCache.image, productionCompanies: [ProductionCompanies](), productionCountries: [ProductionCountries](), releaseDate: movieCache.date, revenue: 333, runtime: 3, spokenLanguages: [SpokenLanguages](), status: "", tagline: "", title: movieCache.title, video: false, voteAverage: movieCache.voteAverage, voteCount: 333)
        let response = MovieDetail.FetchDetailMovie.Response(reponseDetailMovie: detailMovie)
        completion(response)
    }

    func getMovieVideo(movieId: Int, completion: @escaping (MovieVideo) -> Void) {
        let request =  APIRequest()
        request.completeUrl = "movie/\(movieId)/videos"
        let result : Observable<MovieVideo> = APIService.apiCalling.getMovieVideo(apiRequest: request)
        result.subscribe(
            onNext: { result in
                completion(result)
            },
            onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
}
