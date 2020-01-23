//
//  QuizPresenter.swift
//  QuizChallenge
//
//  Created by Rodrigo Pacheco on 23/01/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import Foundation
import UIKit

class QuizPresenter {
    
    var quiz: Quiz?
    
    init() {
        load()
    }
    
    func load() {
        let apiProvider = WordsApiProvider()
        apiProvider.request(for: WordsApiGetEndpoint.words) { [weak self] (result: Result<Quiz, Error>) in

            switch result {
            case .success(let quiz):
                let eventViewModels = quiz
                
                self?.setup(with: eventViewModels)
            case .failure:
                print("FALHO O LOAD")
//                self?.setup(with: )
            }
        }
    }
    
    private func setup(with quiz: Quiz) {
        DispatchQueue.main.async {
            let question: String = quiz.question
            print("QUESTIOOOOON:    ", quiz.question)
            let words: [String] = quiz.answers
            print("ANSWERRRRRRR:    ", quiz.answers)
        }
    }
}
