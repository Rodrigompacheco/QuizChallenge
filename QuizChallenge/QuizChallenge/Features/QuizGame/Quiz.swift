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
    var answers: [String]
    
    // MARK: - Codable
    private enum CodingKeys: String, CodingKey {
        case question = "question"
        case answers = "answer"
    }
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        question = try container.decode(String.self, forKey: .question)
        answers = try container.decode([String].self, forKey: .answers)
    }
    
    func getAnswer(at index: Int) -> String? {
        guard index < answers.count else { return nil }
        return answers[index]
    }
}

