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
    func updateTextButton(to text: String)
    func updateNumberOfHits(to text: String)
    func startTimer()
    func stopTimer()
    func resetTimer()
    func cleanTextField()
    func showDialog(with title: String, message: String, titleButton: String)
}

class QuizPresenter {
    
    var quiz: Quiz?
    var totalAnswers: Int = 0
    var userAnswers: [String] = []
    var isTimerRunnig = false
    var numberOfHits = 0
    
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
                self.totalAnswers = quiz.answers.count
            }
        }
    }
    
    private func resetQuiz() {
        userAnswers = []
        numberOfHits = 0
        
    }
    private func updateComponents() {
        delegate?.cleanTextField()
        delegate?.reloadAnswers()
        delegate?.updateNumberOfHits(to: "\(numberOfHits)/\(totalAnswers)")
    }
    func getNumberOfAnswers() -> Int {
        return userAnswers.count
    }
    
    func getAnswer(at index: Int) -> String {
        guard index < userAnswers.count else { return "" }
        return userAnswers[index]
    }
    
    func validateAnswer(answer: String) {
        guard let quiz = quiz else { return }
        
        if !isTimerRunnig {
            delegate?.showDialog(with: mustStartTimerTitle, message: mustStartTimerMessage, titleButton: "Ok")
            return
        }
        
        let trimmedAnswer = answer.trimmingCharacters(in: .whitespaces).lowercased()
        
        if userAnswers.contains(trimmedAnswer) {
            delegate?.showDialog(with: wordAlreadyAddedTitle, message: wordAlreadyAddedMessage, titleButton: "Ok")
            return
        }
        
        if quiz.answers.contains(trimmedAnswer) {
            userAnswers.append(trimmedAnswer)
            numberOfHits += 1
            updateComponents()
        } else {
            delegate?.showDialog(with: isNotAKeywordTitle, message: isNotAKeywordMessage, titleButton: "Ok")
        }
    }
}

extension QuizPresenter: QuizViewControllerDelegate {
    func startTimerPressed() {
        if isTimerRunnig {
            delegate?.resetTimer()
            delegate?.updateTextButton(to: startTitleButton)
            resetQuiz()
            load()
            updateComponents()
            isTimerRunnig = false
        } else {
            delegate?.startTimer()
            delegate?.updateTextButton(to: resetTitleButton)
            isTimerRunnig = true
        }
    }
}

extension QuizPresenter: CountDownTimerDelegate {
    func timeOut() {
        //Body
    }
}
