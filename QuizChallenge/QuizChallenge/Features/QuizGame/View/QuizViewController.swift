//
//  ViewController.swift
//  QuizChallenge
//
//  Created by Rodrigo Pacheco on 23/01/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var answersTableView: UITableView! {
        didSet {
            answersTableView.register(AnswerTableViewCell.self, forCellReuseIdentifier: AnswerTableViewCell.description())
        }
    }
    @IBOutlet weak var numberOfHitsLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startTimerButton: UIButton!
    @IBOutlet weak var insertWordTextField: CustomTextField!
    
    var presenter: QuizPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        presenter = QuizPresenter()
        setup()
    }
    
    private func setup() {
        startTimerButton.layer.cornerRadius = bottomButtonCornerRadius
        insertWordTextField.layer.cornerRadius = textFieldCornerRadius
    }

    @IBAction func startOrStopTimer(_ sender: Any) {
        
    }
}
