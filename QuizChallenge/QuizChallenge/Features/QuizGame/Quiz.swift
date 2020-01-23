//
//  Quiz.swift
//  QuizChallenge
//
//  Created by Rodrigo Pacheco on 23/01/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import Foundation

struct Quiz: Codable {
    
    let question: String
    let answers: [String]
    
    // MARK: - Codable
    private enum CodingKeys: String, CodingKey {
        case question
        case answers
    }
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        question = try container.decode(String.self, forKey: .question)
        answers = [try container.decode(String.self, forKey: .answers)]
    }
}

