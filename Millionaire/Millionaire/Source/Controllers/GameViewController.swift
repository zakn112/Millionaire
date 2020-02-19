//
//  GameViewController.swift
//  Millionaire
//
//  Created by Андрей Закусов on 15.02.2020.
//  Copyright © 2020 Андрей Закусов. All rights reserved.
//

import Foundation
import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    
    @IBOutlet weak var hintHelpAudienceButton: UIButton!
    @IBOutlet weak var hintCallFriendButton: UIButton!
    @IBOutlet weak var hint5050Button: UIButton!
    @IBOutlet weak var hintChangeQuestionButton: UIButton!
    
    
    var gameSession: GameSession?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gameSession = GameSession()
        gameSession?.gameViewDelegate = self
        setupView()
    }
    
    func setupView(){
        answer1Button.layer.borderColor = UIColor.yellow.cgColor
        answer1Button.layer.borderWidth = 1
        answer1Button.layer.cornerRadius = 15
        
        answer2Button.layer.borderColor = UIColor.yellow.cgColor
        answer2Button.layer.borderWidth = 1
        answer2Button.layer.cornerRadius = 15
        
        answer3Button.layer.borderColor = UIColor.yellow.cgColor
        answer3Button.layer.borderWidth = 1
        answer3Button.layer.cornerRadius = 15
        
        answer4Button.layer.borderColor = UIColor.yellow.cgColor
        answer4Button.layer.borderWidth = 1
        answer4Button.layer.cornerRadius = 15
        
        hintHelpAudienceButton.layer.borderColor = UIColor.yellow.cgColor
        hintHelpAudienceButton.layer.borderWidth = 1
        hintHelpAudienceButton.layer.cornerRadius = 15
        
        hintCallFriendButton.layer.borderColor = UIColor.yellow.cgColor
        hintCallFriendButton.layer.borderWidth = 1
        hintCallFriendButton.layer.cornerRadius = 15
        
        hint5050Button.layer.borderColor = UIColor.yellow.cgColor
        hint5050Button.layer.borderWidth = 1
        hint5050Button.layer.cornerRadius = 15
        
        hintChangeQuestionButton.layer.borderColor = UIColor.yellow.cgColor
        hintChangeQuestionButton.layer.borderWidth = 1
        hintChangeQuestionButton.layer.cornerRadius = 15
    }
    
    @IBAction func answer1Press(_ sender: Any) {
        setResponse(number: 1)
    }
    
    @IBAction func answer2Press(_ sender: Any) {
        setResponse(number: 2)
    }
    
    @IBAction func answer3Press(_ sender: Any) {
        setResponse(number: 3)
    }
    
    @IBAction func answer4Press(_ sender: Any) {
        setResponse(number: 4)
    }
    
    @IBAction func hintHelpAudienceButtonPress(_ sender: Any) {
        guard let gameSession = gameSession, gameSession.hintHelpAudience else { return }
        gameSession.setHintHelpAudience()
    }
    
    @IBAction func hintCallFriendButtonPress(_ sender: Any) {
        guard let gameSession = gameSession, gameSession.hintCallFriend else { return }
        gameSession.setHintCallFriend()
    }
    
    @IBAction func hint5050ButtonPress(_ sender: Any) {
        guard let gameSession = gameSession, gameSession.hint5050 else { return }
        gameSession.setHint5050()
    }
    
    @IBAction func hintChangeQuestionButtonPress(_ sender: Any) {
        guard let gameSession = gameSession, gameSession.hintChangeQuestion else { return }
        gameSession.setHintChangeQuestion()
    }
    
    
    func setResponse(number: Int) {
        guard let gameSession = gameSession else {return}
        
        gameSession.setResponse(numberRespons: number)
    }
    

}

extension GameViewController: GameSceneDelegate {
    func didEndGame(withResult result: Int, currentAnswer: Int, correctAnswer: Int) {
        switch currentAnswer {
        case 1: answer1Button.backgroundColor = UIColor.red
        case 2: answer2Button.backgroundColor = UIColor.red
        case 3: answer3Button.backgroundColor = UIColor.red
        case 4: answer4Button.backgroundColor = UIColor.red
        default:
            return
        }
        
        switch correctAnswer {
        case 1: answer1Button.backgroundColor = UIColor.green
        case 2: answer2Button.backgroundColor = UIColor.green
        case 3: answer3Button.backgroundColor = UIColor.green
        case 4: answer4Button.backgroundColor = UIColor.green
        default:
            return
        }
        
        let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: false){ timer in
            self.dismiss(animated: true, completion: nil)
        }
    }
   
    
    func reloadQuestion(question: Question) {
        questionLabel.text = question.questionText
        
        answer1Button.setTitle( question.answer1, for: .normal)
        answer1Button.backgroundColor = UIColor.blue
        answer1Button.isHidden = false
        
        answer2Button.setTitle( question.answer2, for: .normal)
        answer2Button.backgroundColor = UIColor.blue
        answer2Button.isHidden = false
        
        answer3Button.setTitle( question.answer3, for: .normal)
        answer3Button.backgroundColor = UIColor.blue
        answer3Button.isHidden = false
        
        answer4Button.setTitle( question.answer4, for: .normal)
        answer4Button.backgroundColor = UIColor.blue
        answer4Button.isHidden = false
    }
    
    func setHintHelpAudience(answer: Int) {
        switch answer {
        case 1: answer1Button.backgroundColor = UIColor.yellow
        case 2: answer2Button.backgroundColor = UIColor.yellow
        case 3: answer3Button.backgroundColor = UIColor.yellow
        case 4: answer4Button.backgroundColor = UIColor.yellow
        default:
            return
        }
        
        hintHelpAudienceButton.backgroundColor = UIColor.gray
        
    }
    
    func setHintCallFriend(answer: Int) {
        switch answer {
        case 1: answer1Button.backgroundColor = UIColor.yellow
        case 2: answer2Button.backgroundColor = UIColor.yellow
        case 3: answer3Button.backgroundColor = UIColor.yellow
        case 4: answer4Button.backgroundColor = UIColor.yellow
        default:
            return
        }
        
        hintCallFriendButton.backgroundColor = UIColor.gray
        
    }
    
    func setHint5050(answer1: Int, answer2: Int) {
        switch answer1 {
        case 1: answer1Button.isHidden = true
        case 2: answer2Button.isHidden = true
        case 3: answer3Button.isHidden = true
        case 4: answer4Button.isHidden = true
        default:
            return
        }
        
        switch answer2 {
        case 1: answer1Button.isHidden = true
        case 2: answer2Button.isHidden = true
        case 3: answer3Button.isHidden = true
        case 4: answer4Button.isHidden = true
        default:
            return
        }
        
        hint5050Button.backgroundColor = UIColor.gray
    }
    
    func setHintChangeQuestion(question: Question) {
        hintChangeQuestionButton.backgroundColor = UIColor.gray
        reloadQuestion(question: question)
    }
    
}
