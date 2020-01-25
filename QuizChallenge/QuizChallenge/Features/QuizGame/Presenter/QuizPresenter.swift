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
    func updateTableViewStatus(to hidden: Bool)
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
    var isTimerRunning = false
    var isToReset = false
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
                self?.isToReset = true
                self?.delegate?.hideLoadingView()
                self?.delegate?.showDialog(with: errorFetchDataTitle,
                                           message: errorFetchDataMessage,
                                           titleButton: defaultOkButton)
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
                self.delegate?.updateNumberOfHits(to: "\(self.numberOfHits)/\(self.totalAnswers)")
            }
        }
    }
    
    private func resetQuiz() {
        delegate?.resetTimer()
        delegate?.updateTextButton(to: startTitleButton)
        delegate?.updateTableViewStatus(to: true)
        userAnswers = []
        numberOfHits = 0
        load()
        updateComponents()
        isTimerRunning = false
        isToReset = false
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
        
        if !isTimerRunning {
            delegate?.showDialog(with: mustStartTimerTitle,
                                 message: mustStartTimerMessage,
                                 titleButton: defaultOkButton)
            return
        }
        
        let trimmedAnswer = answer.trimmingCharacters(in: .whitespaces).lowercased()
        if userAnswers.contains(trimmedAnswer) {
            delegate?.showDialog(with: wordAlreadyAddedTitle,
                                 message: wordAlreadyAddedMessage,
                                 titleButton: defaultOkButton)
            return
        }
        
        if quiz.answers.contains(trimmedAnswer) {
            userAnswers.append(trimmedAnswer)
            numberOfHits += 1
            delegate?.updateTableViewStatus(to: false)
            updateComponents()
        }
    }
    
    func checkIfIsOver() -> Bool {
        return userAnswers.count == totalAnswers ? true : false
    }
}

extension QuizPresenter: QuizViewControllerDelegate {
    func dialogButtonPressed() {
        if isToReset {
            resetQuiz()
        }
    }
    
    func wordTyped(word: String) {
        validateAnswer(answer: word)
        if checkIfIsOver() {
            isToReset = true
            delegate?.stopTimer()
            delegate?.showDialog(with: finishQuizTitle,
                                 message: finishQuizMessage,
                                 titleButton: finishQuizBtnTitle)
        }
    }
    
    func startTimerPressed() {
        if isTimerRunning {
            resetQuiz()
        } else {
            delegate?.startTimer()
            delegate?.updateTextButton(to: resetTitleButton)
            isTimerRunning = true
        }
    }
}

extension QuizPresenter: CountDownTimerDelegate {
    func timeOut() {
        isToReset = true
        delegate?.stopTimer()
        delegate?.showDialog(with: notFinishQuizTitle,
                             message: notFinishedDialogMessage(userAnswers: userAnswers.count, totalAnswers: totalAnswers),
                             titleButton: notFinishQuizBtnTitle)
    }
}
