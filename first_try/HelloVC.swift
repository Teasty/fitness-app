//
//  HelloVC.swift
//  first_try
//
//  Created by Андрей Лихачев on 22/04/2019.
//  Copyright © 2019 Андрей Лихачев. All rights reserved.
//

import UIKit

class HelloVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    var client_name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "Привет " + UserDefaults.standard.string(forKey: "user_name")! + "!"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.performSegue(withIdentifier: "welcome", sender: self.storyboard)
        }
    }
    
}
