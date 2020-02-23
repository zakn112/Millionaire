//
//  SettingsViewController.swift
//  Millionaire
//
//  Created by Андрей Закусов on 23.02.2020.
//  Copyright © 2020 Андрей Закусов. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var questionUsageMode: UISegmentedControl!
    
    @IBAction func questionUsageModePress(_ sender: Any) {
        switch questionUsageMode.selectedSegmentIndex {
        case 0: Game.shared.questionUsageMode = .сonsistently
        case 1: Game.shared.questionUsageMode = .randomly
        default: Game.shared.questionUsageMode = .сonsistently
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Game.shared.questionUsageMode == .randomly {
            questionUsageMode.selectedSegmentIndex = 1
        }

    }
    
    
}
