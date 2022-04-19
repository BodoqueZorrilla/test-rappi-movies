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
}

protocol MovieDetailDataStore {
    var idMovie: Int { get set }
}

class MovieDetailInteractor: Interactor, MovieDetailBusinessLogic, MovieDetailDataStore {
    lazy var presenter: MovieDetailPresentationLogic = {
        return self._presenter as! MovieDetailPresentationLogic
    }()
    let worker = MovieDetailWorker()
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
    
}