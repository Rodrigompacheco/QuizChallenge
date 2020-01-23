//
//  WordsApiError.swift
//  QuizChallenge
//
//  Created by Rodrigo Pacheco on 23/01/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import Foundation

enum WordsApiError: Error {
    case custom(String)
}

extension WordsApiError {
    static var makeRequest: WordsApiError {
        return WordsApiError.custom("Couldn't create request.")
    }
    
    static var decode: WordsApiError {
        return WordsApiError.custom("Couldn't decode data.")
    }
}
