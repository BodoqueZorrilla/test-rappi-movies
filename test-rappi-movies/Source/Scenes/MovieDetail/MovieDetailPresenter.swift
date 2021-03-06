//
//  MovieDetailPresenter.swift
//  test-rappi-movies
//
//  Created by Sergio Zorrilla Arellano on 15/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the iOS team Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//

import UIKit

protocol MovieDetailPresentationLogic {
    func presentDetailMovieScene(response: MovieDetail.FetchDetailMovie.Response)
    func presentVideo(keyVideo: String)
}

class MovieDetailPresenter: Presenter, MovieDetailPresentationLogic {
    
    lazy var view: MovieDetailDisplayLogic = {
        return self._view as! MovieDetailDisplayLogic
    }()
    
    func presentDetailMovieScene(response: MovieDetail.FetchDetailMovie.Response) {
        var viewModel = MovieDetail.FetchDetailMovie.ViewModel()
        viewModel.movieImage = response.reponseDetailMovie?.posterPath
        viewModel.genres = response.reponseDetailMovie?.genres
        viewModel.overview = response.reponseDetailMovie?.overview
        viewModel.title = response.reponseDetailMovie?.title
        viewModel.voteAverage = response.reponseDetailMovie?.voteAverage
        let date = DateFormatter.string(iso: response.reponseDetailMovie?.releaseDate ?? "")
        let toSeconds = (response.reponseDetailMovie?.runtime ?? 0) * 60
        let time = timeString(time: TimeInterval(toSeconds))
        viewModel.datetime = "\(date) - \(time)"
        view.displayDetailMovieScene(viewModel: viewModel)
    }

    private func timeString(time: TimeInterval) -> String {
        let hour = Int(time) / 3600
        let minute = Int(time) / 60 % 60
        return String(format: "%02ih %02im", hour, minute)
    }

    func presentVideo(keyVideo: String) {
        view.displayVideo(keyVideo: keyVideo)
    }
}
