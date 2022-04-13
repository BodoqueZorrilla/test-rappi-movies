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
    var baseURL = URL(string: APIStrings.mainURL)!
    var method = RequestType.GET
    var parameters = [String: String]()

    func request(with baseURL: URL) -> URLRequest {
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
            let request = apiRequest.request(with: apiRequest.baseURL)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    let model: ReponseMainMovies = try JSONDecoder().decode(ReponseMainMovies.self, from: data ?? Data())
                    observer.onNext( model.results as! T)
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
