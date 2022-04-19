//
//  APIService.swift
//  test-rappi-movies
//
//  Created by Sergio Zorrilla Arellano on 11/04/22.
//

import Foundation
import RxSwift

struct APIStrings {
    static let apiKey = Bundle.main.infoDictionary!["API_KEY"] as? String
    static let mainURL = "https://api.themoviedb.org/3/"
    static let imagesURL = "https://image.tmdb.org/t/p/w300"
}

public enum RequestType: String {
    case GET, POST, PUT,DELETE
}

class APIRequest {
    var completeUrl = String()
    var method = RequestType.GET
    var parameters = [String: String]()

    func request(with completeUrl: String) -> URLRequest {
        let baseURL =  URL(string: APIStrings.mainURL + completeUrl + "?api_key=\(APIStrings.apiKey ?? "")")!
        var request = URLRequest(url: baseURL)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}


class APIService {
    
    static let apiCalling = APIService()

    func getMovies<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = apiRequest.request(with: apiRequest.completeUrl)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    let model: ReponseMainMovies = try JSONDecoder().decode(ReponseMainMovies.self, from: data ?? Data())
                     observer.onNext( model.results as! T )
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }

    func getMovieDetail<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = apiRequest.request(with: apiRequest.completeUrl)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    let model: ReponseDetailMovie = try JSONDecoder().decode(ReponseDetailMovie.self, from: data ?? Data())
                    observer.onNext( model as! T )
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }

    func getMovieVideo<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = apiRequest.request(with: apiRequest.completeUrl)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    let model: MovieVideo = try JSONDecoder().decode(MovieVideo.self, from: data ?? Data())
                    observer.onNext( model as! T )
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
