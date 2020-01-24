//
//  CountDownTimer.swift
//  QuizChallenge
//
//  Created by Rodrigo Pacheco on 24/01/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import UIKit

protocol CountDownTimerDelegate: class {
    func timeOut()
}

class CountDownTimer: UILabel {
        
    var seconds: Int = initialTimeSecods
    var timer = Timer()
    var isTimerRunning = false
    
    weak var delegate: CountDownTimerDelegate?
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    func stopTimer() {
        timer.invalidate()
        isTimerRunning = false
    }
    
    func resetTimer() {
        timer.invalidate()
        seconds = initialTimeSecods
        self.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
    }
    
    func setInicialTime(to seconds: Int) {
        self.seconds = seconds
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            delegate?.timeOut()
        } else {
            seconds -= 1
            self.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}
