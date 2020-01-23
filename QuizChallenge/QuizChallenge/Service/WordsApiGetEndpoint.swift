//
//  WordsApiGetEndpoint.swift
//  QuizChallenge
//
//  Created by Rodrigo Pacheco on 23/01/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import Foundation

enum WordsApiGetEndpoint {
    case words
}

extension WordsApiGetEndpoint {
    static let baseUrl = "https://codechallenge.arctouch.com/1"

    var path: String {
        switch self {
        case .words:
            return "/quiz/1"
        }
    }

    var headers: [String: String] {
        switch self {
        case .words:
            return ["Content-Type": "Application/json"]
        }
    }

    func makeRequest() -> URLRequest? {
        guard let url = URL(string: WordsApiGetEndpoint.baseUrl + path) else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }

        return request
    }

}
