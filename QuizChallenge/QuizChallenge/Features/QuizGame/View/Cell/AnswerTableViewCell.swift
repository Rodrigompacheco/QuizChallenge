//
//  AnswerTableViewCell.swift
//  QuizChallenge
//
//  Created by Rodrigo Pacheco on 24/01/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var answerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(answer: String) {
        answerLabel.text = answer
    }
}
