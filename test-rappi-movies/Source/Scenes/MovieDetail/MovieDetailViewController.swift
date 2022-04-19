//
//  MovieDetailViewController.swift
//  test-rappi-movies
//
//  Created by Sergio Zorrilla Arellano on 15/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the iOS team Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//

import UIKit
import AVFoundation
import WebKit

protocol MovieDetailDisplayLogic: View {
    func displayDetailMovieScene(viewModel: MovieDetail.FetchDetailMovie.ViewModel)
    func displayVideo(keyVideo: String)
}

class MovieDetailViewController: UIViewController {

    // MARK: - Variables
    
    lazy var interactor: MovieDetailBusinessLogic = {
        return self._interactor as! MovieDetailBusinessLogic
    }()

    var router: (MovieDetailRoutingLogic & MovieDetailDataGet)?

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis  = .vertical
        sv.alignment = .center
        sv.distribution = .fill
        sv.spacing = 20
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    let gendersStackView: UIStackView = {
        let gendersSV = UIStackView()
        gendersSV.axis  = .horizontal
        gendersSV.alignment = .leading
        gendersSV.distribution = .fill
        gendersSV.spacing = 10
        gendersSV.translatesAutoresizingMaskIntoConstraints = false
        return gendersSV
    }()

    var youtubeWebView: WKWebView = {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        let youtube = WKWebView(frame: .zero,
                                configuration: config)
        youtube.translatesAutoresizingMaskIntoConstraints = false
        return youtube
    }()

    let movieDateLabel: UILabel = {
        let date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.textColor = .gray
        date.numberOfLines = 0
        date.textAlignment = .center
        date.font = UIFont.systemFont(ofSize: 18)
        return date
    }()

    let movieDescriptionLabel: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.textColor = .white
        description.numberOfLines = 0
        description.textAlignment = .natural
        description.font = UIFont.systemFont(ofSize: 18)
        return description
    }()

    var ratingView: RatingView = {
        let rating = RatingView()
        rating.translatesAutoresizingMaskIntoConstraints = false
        return rating
    }()
    
    // MARK: - Object Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.interactor.fetchMovieDetail()
        self.interactor.fetchVideo()
    }
    
    // MARK: - Configurators
    
    fileprivate func setup() {
        let viewController = self
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter()
        let router = MovieDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.view = viewController
        router.view = viewController
        router.dataStore = interactor
    }

    fileprivate func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(youtubeWebView)
        stackView.addArrangedSubview(gendersStackView)
        stackView.addArrangedSubview(movieDateLabel)
        stackView.addArrangedSubview(ratingView)
        stackView.addArrangedSubview(movieDescriptionLabel)

        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)

        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        youtubeWebView.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 5).isActive = true
        youtubeWebView.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -5).isActive = true

        movieDescriptionLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 20).isActive = true
        movieDescriptionLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -20).isActive = true
        
        
        youtubeWebView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        ratingView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        ratingView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // MARK: - Private

    private func fetchGenres(genres: [Genres]) {
        for genre in genres {
            let label = UILabel()
            label.textColor = .black
            label.numberOfLines = 1
            label.textAlignment = .center
            label.text = genre.name
            label.backgroundColor = .white
            label.font = UIFont.systemFont(ofSize: 16)
            label.layer.cornerRadius = 5
            label.layer.masksToBounds = true
            label.setContentHuggingPriority(.required, for: .horizontal)
            self.gendersStackView.addArrangedSubview(label)
        }
    }

    private func getFrameVideo(keyVideo: String) -> String {
        return """
        <iframe width="100%" height="97%" src="https://www.youtube.com/embed/\(keyVideo)?playsinline=1" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        """
    }
    
    // MARK: - Actions
    
    
}

extension MovieDetailViewController: MovieDetailDisplayLogic {
    func displayDetailMovieScene(viewModel: MovieDetail.FetchDetailMovie.ViewModel) {
        DispatchQueue.main.async {
            self.movieDateLabel.text = viewModel.datetime ?? ""
            self.navigationItem.title = viewModel.title ?? ""
            self.fetchGenres(genres: viewModel.genres ?? [])
            self.movieDescriptionLabel.text = viewModel.overview ?? ""
            self.ratingView.percent = viewModel.voteAverage ?? 0.0
            self.ratingView.setNeedsLayout()
            self.ratingView.layoutIfNeeded()
        }
    }

    func displayVideo(keyVideo: String) {
        DispatchQueue.main.async {
            self.youtubeWebView.loadHTMLString(self.getFrameVideo(keyVideo: keyVideo),
                                               baseURL: nil)
        }
    }
}