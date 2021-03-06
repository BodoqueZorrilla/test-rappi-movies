//
//  MovieDetailInteractor.swift
//  test-rappi-movies
//
//  Created by Sergio Zorrilla Arellano on 15/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the iOS team Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//

import Foundation


protocol MovieDetailBusinessLogic {
    func fetchMovieDetail()
    func fetchVideo()
    func saveCacheMovie(request: MovieDetail.FetchDetailMovie.ViewModel)
    func fetchMovieDetailOffline()
}

protocol MovieDetailDataStore {
    var idMovie: Int { get set }
}

class MovieDetailInteractor: Interactor, MovieDetailBusinessLogic, MovieDetailDataStore {
    lazy var presenter: MovieDetailPresentationLogic = {
        return self._presenter as! MovieDetailPresentationLogic
    }()
    var worker: MovieDetailWorkerInterface = MovieDetailWorker()
    var idMovie: Int = 0

    func fetchMovieDetail() {
        self.worker.getMovieDetail(movieId: idMovie) { response in
            self.presenter.presentDetailMovieScene(response: response)
        }
    }

    func fetchVideo() {
        self.worker.getMovieVideo(movieId: idMovie) { response in
            if let results = response.results {
                let filtered = results.filter { movie in
                    if let name = movie.name {
                        return name.contains("Official Tra")
                    } else {
                        return true
                    }
                }
                let realResult = filtered.count > 0 ? filtered : results
                self.presenter.presentVideo(keyVideo: realResult.first?.key ?? "cpLZeSigNvY")
            }
        }
    }

    func saveCacheMovie(request: MovieDetail.FetchDetailMovie.ViewModel) {
        let voMovie = VOMovie(id: Int64(idMovie),
                              title: request.title ?? "",
                              overview: request.overview ?? "",
                              date: request.datetime ?? "",
                              voteAverage: request.voteAverage ?? 0.0,
                              genders: request.genres?.first?.name ?? "",
                              image: "",
                              section: "")

        CoreDataMovieManager.shared.updateMovie(voMovie)
    }

    func fetchMovieDetailOffline() {
        self.worker.getMovieDetailOffline(movieId: idMovie) { response in
            self.presenter.presentDetailMovieScene(response: response)
        }
    }
}
