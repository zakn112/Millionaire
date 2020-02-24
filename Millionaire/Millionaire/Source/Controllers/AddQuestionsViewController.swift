//
//  AddQuestionsViewController.swift
//  Millionaire
//
//  Created by Андрей Закусов on 23.02.2020.
//  Copyright © 2020 Андрей Закусов. All rights reserved.
//

import UIKit

class AddQuestionsViewController: UIViewController,  UITableViewDataSource{
    var cellCount = 0
    var questionsBuilder = QuestionsBuilder()

    @IBOutlet weak var questionsTableView: UITableView!
    
    @IBOutlet weak var addQuestionButton: UIButton!
    
    @IBOutlet weak var saveQuestionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.questionsTableView.dataSource = self
      
    }
    
    @IBAction func addQuestionButtonPress(_ sender: Any) {
        let indexPaths = [IndexPath(row: cellCount, section: 0)]
        cellCount += 1
        questionsTableView.beginUpdates()
        questionsTableView.insertRows(at: indexPaths, with: .automatic)
        questionsTableView.endUpdates()
        
    }
    
    @IBAction func saveQuestionButtonPress(_ sender: Any) {
        let newQuestions = questionsBuilder.build()
        let questionsCaretaker = QuestionsCaretaker()
        questionsCaretaker.saveByAdding(results: newQuestions)
        
        let alert = UIAlertController(title: "Вопросы сохранены", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: { action in
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @IBAction func canselQuestionButtonPress(_ sender: Any) {
        let alert = UIAlertController(title: "Отмена сохранения", message: "Введенные данные будут потеряны. Продолжить?", preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Да", style: .cancel, handler: { action in
            self.dismiss(animated: true, completion: nil)
        })
        let actionNo = UIAlertAction(title: "Нет", style: .cancel, handler: nil)
        alert.addAction(actionYes)
        alert.addAction(actionNo)
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.questionsTableView.dequeueReusableCell(withIdentifier: "QuestionsTableViewCell", for: indexPath) as! QuestionsTableViewCell
        
        cell.questionsBuilder = questionsBuilder
        cell.numberQuestion = indexPath.row
        return cell
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

