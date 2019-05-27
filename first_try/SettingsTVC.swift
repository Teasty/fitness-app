//
//  SettingsTVC.swift
//  first_try
//
//  Created by Андрей Лихачев on 25/04/2019.
//  Copyright © 2019 Андрей Лихачев. All rights reserved.
//

import Foundation
import UIKit

class SettingsTVC: UITableViewController{
    
    @IBOutlet weak var UserNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserNameLabel.text = UserDefaults.standard.string(forKey: "user_familia")! + " " + UserDefaults.standard.string(forKey: "user_name")! + " " + UserDefaults.standard.string(forKey: "user_otchestvo")!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 && indexPath.row == 0{
            UserDefaults.standard.deleteUserId()
            performSegue(withIdentifier: "exit", sender: self.storyboard)
        }
    }
}
