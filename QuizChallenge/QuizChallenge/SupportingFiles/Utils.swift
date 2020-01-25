//
//  Utils.swift
//  QuizChallenge
//
//  Created by Rodrigo Pacheco on 24/01/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import Foundation
import UIKit

// Mark: cornerRadius
let bottomButtonCornerRadius: CGFloat = 10
let textFieldCornerRadius: CGFloat = 10
let loadingViewCornerRadius: CGFloat = 20

// Mark: tags
let loadingViewTag: Int = 1

// Mark: CoundDownTimer
let initialTimeSeconds: Int = 300

// Mark: Strings
let startTitleButton: String = "Start"
let resetTitleButton: String = "Reset"
/// Dialog Messages
let isNotAKeywordTitle: String = "Ops!"
let isNotAKeywordMessage: String = "This answer isn't a keyword"

let mustStartTimerTitle: String = "Warning"
let mustStartTimerMessage: String = "You must Start timer"

let wordAlreadyAddedTitle: String = "Warning"
let wordAlreadyAddedMessage: String = "This word was already added"

let finishQuizTitle: String = "Congratulations"
let finishQuizMessage: String = "Good job! You found all the answers on time. Keep up with the great work."
let finishQuizBtnTitle: String = "Play Again"

let notFinishQuizTitle: String = "Time finished"
let notFinishQuizBtnTitle: String = "Try Again"

func notFinishedDialogMessage(userAnswers: Int, totalAnswers: Int) -> String {
    return "Sorry, time is up! You got \(userAnswers) out of \(totalAnswers) answers."
}

