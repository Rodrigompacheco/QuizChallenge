//
//  QuizChallengeTests.swift
//  QuizChallengeTests
//
//  Created by Rodrigo Pacheco on 25/01/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import XCTest
@testable import QuizChallenge

class QuizChallengeTests: XCTestCase {

    var presenter: QuizPresenter!
    let mockAnswers: [String] = ["abstract", "assert", "boolean", "break", "byte", "case", "catch", "char", "class", "const", "continue", "default"]
    
    override func setUp() {
        presenter = QuizPresenter()
        presenter.quiz = Quiz(question: "What are all the java keywords?", answers: mockAnswers)
        presenter.totalAnswers = presenter.quiz?.answers.count ?? 0
    }

    func testRightAnswer() {
        let answer = "abstract"
        let result = presenter.validateAnswer(answer: answer)
        XCTAssertTrue(result)
    }
    
    func testWrongAnswer() {
        let answer = "abc"
        let result = presenter.validateAnswer(answer: answer)
        XCTAssertFalse(result)
    }
    
    func testAnswerAlreadySaved() {
        let answer = "abstract"
        presenter.userAnswers.append(answer)
        let result = presenter.validateAnswer(answer: answer)
        XCTAssertFalse(result)
    }
    
    func testQuizFinished() {
        presenter.userAnswers = mockAnswers
        let result = presenter.checkIfIsOver()
        XCTAssertTrue(result)
    }
    
    func testNumberOfAnswers() {
        presenter.userAnswers = mockAnswers
        let result = presenter.getNumberOfAnswers()
        XCTAssertEqual(result, mockAnswers.count)
    }
    
    func testResetQuizNumberOfAnswers() {
        presenter.isToReset = true
        presenter.dialogButtonPressed()
        let numberOfAnswers = presenter.getNumberOfAnswers()
        XCTAssertEqual(numberOfAnswers, 0)
    }
    
    func testResetQuizNumberHits() {
        presenter.isToReset = true
        presenter.dialogButtonPressed()
        let numberOfHits = presenter.numberOfHits
        XCTAssertEqual(numberOfHits, 0)
    }
    
    func testQuizNotFinished() {
        presenter.userAnswers = mockAnswers
        presenter.userAnswers.removeLast()
        let result = presenter.checkIfIsOver()
        XCTAssertFalse(result)
    }
}
