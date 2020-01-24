//
//  ViewController.swift
//  QuizChallenge
//
//  Created by Rodrigo Pacheco on 23/01/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import UIKit

protocol QuizViewControllerDelegate: class {
    func startTimerPressed()
}

class QuizViewController: UIViewController {
    
    @IBOutlet weak var answersTableView: UITableView! {
        didSet {
            answersTableView.register(UINib(nibName: "AnswerTableViewCell", bundle: nil), forCellReuseIdentifier: "AnswerTableViewCell") //.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        }
    }
    @IBOutlet weak var numberOfHitsLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startTimerButton: UIButton!
    @IBOutlet weak var insertWordTextField: CustomTextField!
    
    var presenter: QuizPresenter?
    weak var delegate: QuizViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        presenter = QuizPresenter()
        presenter?.delegate = self
        delegate = presenter
        setup()
    }
    
    private func setup() {
        answersTableView.dataSource = self
        startTimerButton.layer.cornerRadius = bottomButtonCornerRadius
        insertWordTextField.layer.cornerRadius = textFieldCornerRadius
    }

    @IBAction func startOrStopTimer(_ sender: Any) {
        delegate?.startTimerPressed()
    }
}

extension QuizViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = presenter else { return 0 }
        
        return presenter.getNumberOfAnswers()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        guard let presenter = presenter else { return  defaultCell}

        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerTableViewCell") as? AnswerTableViewCell
        cell?.setup(answer: presenter.getAnswer(at: indexPath.row))
        
        return cell ?? defaultCell
    }
}

extension QuizViewController: QuizPresenterDelegate {
    func reloadAnswers() {
        answersTableView.reloadData()
    }
}
