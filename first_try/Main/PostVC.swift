//
//  PostVC.swift
//  first_try
//
//  Created by Андрей Лихачев on 26/05/2019.
//  Copyright © 2019 Андрей Лихачев. All rights reserved.
//

import UIKit

class PostVC: UIViewController {
    
    @IBOutlet weak var PostTitleView: UILabel!
    @IBOutlet weak var PostTextField: UITextView!
    
    var ptitle = String()
    var text = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PostTitleView.text = ptitle
        PostTextField.text = text
        // Do any additional setup after loading the view.
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
