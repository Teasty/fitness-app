//
//  SettingsVC.swift
//  first_try
//
//  Created by Андрей Лихачев on 23/04/2019.
//  Copyright © 2019 Андрей Лихачев. All rights reserved.
//

import Foundation
import UIKit

class SettingsVC: UIViewController{
    
    @IBAction func exitButton(_ sender: UIButton) {
        
        UserDefaults.standard.deleteUserId()
        performSegue(withIdentifier: "exit", sender: sender)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

