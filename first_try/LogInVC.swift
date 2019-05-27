//
//  ViewController.swift
//  first_try
//
//  Created by Андрей Лихачев on 08/04/2019.
//  Copyright © 2019 Андрей Лихачев. All rights reserved.
//

import UIKit

class LogInVC: UIViewController {
    
    var name: String?
    
    struct Response: Codable {
        let text: String
        let client_id: String
        let client_name: String
        let client_familia: String
        let client_otchestvo: String
        let client_email: String
        let client_telephone: String
        let client_birth_date: String
        enum CodingKeys:String, CodingKey {
            case text = "response"
            case client_id = "id"
            case client_name = "name"
            case client_familia = "familia"
            case client_otchestvo = "otchestvo"
            case client_telephone = "telephone"
            case client_email = "email"
            case client_birth_date = "birth_date"
        }
    }

    @IBOutlet weak var textbox: UITextField!
    @IBOutlet weak var deniedlabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func LoginButton(_ sender: UIButton) {
        
        if textbox.text != ""{
            
            loginButton.isEnabled = false
            self.textbox.resignFirstResponder()
            
            let url = "https://firsttryapi.000webhostapp.com/manage.php?action=login_via_card&card_number=\(textbox.text!)"
            
            let books_url = URL(string: url)
            
            URLSession.shared.dataTask(with: books_url!, completionHandler: {(data, response, error) in
                guard let data = data, error == nil else {print(error!); return}
                
                let decoder = JSONDecoder()
                let answer = try! decoder.decode(Response.self, from: data)
                
                if answer.text == "access_granted"{
                    self.name = answer.client_name
                    UserDefaults.standard.setUser(id: answer.client_id, name: answer.client_name, familia: answer.client_familia, otchestvo: answer.client_otchestvo, telephone: answer.client_telephone, email: answer.client_email, birth_date: answer.client_birth_date)
                    
                    DispatchQueue.main.async {
                        self.loginButton.isEnabled = true
                        self.deniedlabel.text = ""
                        self.performSegue(withIdentifier: "hello", sender: sender)
                    }
                } else{
                    
                    DispatchQueue.main.async {
                        self.loginButton.isEnabled = true
                        self.deniedlabel.text = "Простите, к сожалению срок вашего абонемента истек."
                        self.textbox.text = ""
                    }
                }
                
                
                
            }).resume()
        
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textbox.keyboardType = UIKeyboardType.numberPad
        self.navigationItem.hidesBackButton = true
        
        if UserDefaults.standard.isLogedIn() == true{
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "hello", sender: self.storyboard)
            }
        }else{
            textbox.isHidden = false
            loginButton.isHidden = false
        }
    }
    
}

