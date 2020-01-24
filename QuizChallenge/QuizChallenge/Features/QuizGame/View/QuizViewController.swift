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

class QuizViewController: UIViewController, KeyboardObservable {
    
    @IBOutlet weak var answersTableView: UITableView! {
        didSet {
            answersTableView.register(UINib(nibName: "AnswerTableViewCell", bundle: nil), forCellReuseIdentifier: "AnswerTableViewCell") //.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        }
    }
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var numberOfHitsLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startTimerButton: UIButton!
    @IBOutlet weak var insertWordTextField: CustomTextField!
    @IBOutlet weak var botttomViewBottomConstraint: NSLayoutConstraint!
    
    var presenter: QuizPresenter?
    weak var delegate: QuizViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupPresenter()
        setupComponents()
        setupKeyboardHandlers()
    }
    
    private func setupPresenter() {
        presenter = QuizPresenter()
        presenter?.delegate = self
        delegate = presenter
        presenter?.load()
    }
    
    private func setupComponents() {
        answersTableView.dataSource = self
        startTimerButton.layer.cornerRadius = bottomButtonCornerRadius
        insertWordTextField.layer.cornerRadius = textFieldCornerRadius
    }
    
    private func setupKeyboardHandlers() {
        self.hideKeyboardWhenTappedAround()
        
        keyboardWillShowNotification(answersTableView) { [botttomViewBottomConstraint] keyboardSize in
            guard let keyboardHeight = keyboardSize?.height else { return }
            botttomViewBottomConstraint?.constant = -keyboardHeight
        }
        
        keyboardWillHideNotification(answersTableView) { [botttomViewBottomConstraint] _ in
            botttomViewBottomConstraint?.constant = 0
        }
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
    func updateQuestion(to question: String) {
        questionLabel.text = question
    }
    
    func showLoadingView() {
         let loadingView = LoadingView(frame: view.frame)
         view.addSubview(loadingView)
         loadingView.startAnimating()
    }
    
    func hideLoadingView() {
        DispatchQueue.main.async {
            let loadingView = self.view.viewWithTag(LoadingView.tag)
            UIView.animate(withDuration: 0.30, animations: {
                loadingView?.alpha = 0
            }, completion: { completed in
                if completed {
                    (loadingView as? LoadingView)?.stopAnimating()
                    loadingView?.removeFromSuperview()
                }
            })
        }
    }
    
    func reloadAnswers() {
        answersTableView.reloadData()
    }
}
