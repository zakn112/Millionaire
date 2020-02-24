//
//  QuestionsTableViewCell.swift
//  Millionaire
//
//  Created by Андрей Закусов on 23.02.2020.
//  Copyright © 2020 Андрей Закусов. All rights reserved.
//

import UIKit

class QuestionsTableViewCell: UITableViewCell, UITextViewDelegate{
    
    var questionsBuilder: QuestionsBuilder?
    var numberQuestion = 0

    @IBOutlet weak var questionText: UITextView!
    
    @IBOutlet weak var answer1: UITextField!
    @IBOutlet weak var answer2: UITextField!
    @IBOutlet weak var answer3: UITextField!
    @IBOutlet weak var answer4: UITextField!
    
    @IBOutlet weak var correctAnswer: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        questionText.delegate = self
        // Initialization code
    }

    @IBAction func correctAnswerPress(_ sender: Any) {
        questionsBuilder?.setCorrectAnswer(number: numberQuestion, correctAnswer: correctAnswer.selectedSegmentIndex + 1)
    }
    
    func textViewDidChange(_ textView: UITextView) {
       questionsBuilder?.setQuestionText(number: numberQuestion, text: textView.text)
    }
    
    
    @IBAction func answer1Changed(_ sender: UITextField) {
        questionsBuilder?.setAnswer1Text(number: numberQuestion, text: sender.text ?? "")
    }
    
    
    @IBAction func answer2Changed(_ sender: UITextField) {
        questionsBuilder?.setAnswer2Text(number: numberQuestion, text: sender.text ?? "")
    }
    
    @IBAction func answer3Changed(_ sender: UITextField) {
        questionsBuilder?.setAnswer3Text(number: numberQuestion, text: sender.text ?? "")
    }
    
    
    @IBAction func answer4Changed(_ sender: UITextField) {
        questionsBuilder?.setAnswer4Text(number: numberQuestion, text: sender.text ?? "")
    }
    
}
