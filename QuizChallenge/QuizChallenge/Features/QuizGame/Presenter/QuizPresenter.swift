//
//  QuizPresenter.swift
//  QuizChallenge
//
//  Created by Rodrigo Pacheco on 23/01/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import Foundation
import UIKit

protocol QuizPresenterDelegate: class {
    func reloadAnswers()
    func showLoadingView()
    func hideLoadingView()
    func updateQuestion(to question: String)
}

class QuizPresenter {
    
    var quiz: Quiz?
    weak var delegate: QuizPresenterDelegate?
    
    init() {}
    
    func load() {
        delegate?.showLoadingView()
        
        let apiProvider = WordsApiProvider()
        apiProvider.request(for: WordsApiGetEndpoint.words) { [weak self] (result: Result<Quiz, Error>) in
            switch result {
            case .success(let quiz):
                self?.setup(with: quiz)
            case .failure:
                print("FALHO O LOAD")
                self?.delegate?.hideLoadingView()
            }
        }
    }
    
    private func setup(with quiz: Quiz) {
        DispatchQueue.main.async {
            self.quiz = quiz
            self.delegate?.hideLoadingView()
            if let quiz = self.quiz {
                self.delegate?.updateQuestion(to: quiz.question)
            }
            self.delegate?.reloadAnswers()
        }
    }
    
    func getNumberOfAnswers() -> Int {
        guard let quiz = quiz else { return 0 }
        return quiz.answers.count
    }
    
    func getAnswer(at index: Int) -> String {
        if let quiz = quiz, let answer = quiz.getAnswer(at: index) {
            return answer
        }
        return ""
    }
}

extension QuizPresenter: QuizViewControllerDelegate {
    func startTimerPressed() {
        print("START TIME PRESSED")
    }
}

extension QuizPresenter: CountDownTimerDelegate {
    func timeOut() {
        //Body
    }
}
