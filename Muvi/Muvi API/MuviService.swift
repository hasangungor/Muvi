//
//  MuviService.swift
//  Muvi
//
//  Created by HasanEkmob on 19.07.2021.
//

import Foundation
import Alamofire
import Combine

public class MuviService {
    
    public enum MuviURL: String {
        case prod = "https://api.themoviedb.org/3/"
    }
    
    public enum MuviEndPoint: String {
        case topRatedMovies = "movie/top_rated/"
    }
    
    public enum Result<Value, Error> {
        case success(Value)
        case failure(Error)
    }
    
    private var apiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else { return "" }
        return key
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    public static let shared = MuviService()
    private init() {}

    public func getTopRatedMovies(completion: @escaping (Result<String, Error>) -> ()) {
        let baseURL = URL(string: MuviURL.prod.rawValue)!.appendingPathComponent(MuviEndPoint.topRatedMovies.rawValue)
        var urlRequest = URLRequest(url: baseURL)
        urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        let publisher = URLSession.shared.dataTaskPublisher(for: urlRequest)
        let subscriber = publisher.sink { completed in
            switch completed {
            case .finished:
                completion(.success("Succeeded"))
                break
            case .failure(let err):
                completion(.failure(err))
                break
            }
        } receiveValue: { (data: Data, response: URLResponse) in
            guard let res = response as? HTTPURLResponse else { return }
            print(res.statusCode)
            if (200...300).contains(res.statusCode) {
                if let d = String(data: data, encoding: .utf8) {
                    print(d)
                }
            }
        }
        
        subscriber.store(in: &subscriptions)
    }
    
    func fetchTopRatedMovies() {
        // TODO:
        let baseURL = URL(string: MuviURL.prod.rawValue)!.appendingPathComponent(MuviEndPoint.topRatedMovies.rawValue)
        var urlRequest = URLRequest(url: baseURL)
        urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    }
}
