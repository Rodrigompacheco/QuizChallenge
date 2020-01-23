//
//  WordsApiProvider.swift
//  QuizChallenge
//
//  Created by Rodrigo Pacheco on 23/01/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import Foundation

final class EventsApiProvider {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(for endpoint: WordsApiGetEndpoint,
                               completion: @escaping (Result<T, Error>) -> Void) {
        
        if let request = endpoint.makeRequest() {
            session.dataTask(with: request) { (data, _, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let data = data {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .millisecondsSince1970
                    if let model = try? jsonDecoder.decode(T.self, from: data) {
                        completion(.success(model))
                    } else {
                        let error = WordsApiError.decode
                        completion(.failure(error))
                    }
                }
            }.resume()
        } else {
            let error = WordsApiError.makeRequest
            completion(.failure(error))
        }
    }
}

