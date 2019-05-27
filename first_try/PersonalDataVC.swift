//
//  PersonalDataVC.swift
//  first_try
//
//  Created by Андрей Лихачев on 04/05/2019.
//  Copyright © 2019 Андрей Лихачев. All rights reserved.
//

import Foundation
import UIKit

class PersonalDataVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var FIOlabel: UILabel!
    @IBOutlet weak var TelephoneTF: UITextField!
    @IBOutlet weak var BirthDateLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var UpdateButton: UIButton!
    @IBOutlet weak var succsessLabel: UILabel!
    
    struct Response: Codable {
        let text: String
         enum CodingKeys:String, CodingKey {
            case text = "response"
        }
    }
    
    let datePicker = UIDatePicker()
    
    @IBAction func updateBurron(_ sender: UIButton) {
        loadingIndicator.isHidden = false
        UpdateButton.isEnabled = false
        let user_id = UserDefaults.standard.string(forKey: "user_id")!
        let user_familia = UserDefaults.standard.string(forKey: "user_familia")!
        let user_name = UserDefaults.standard.string(forKey: "user_name")!
        let user_otchestvo = UserDefaults.standard.string(forKey: "user_otchestvo")!
        let user_birth_date = UserDefaults.standard.string(forKey: "user_birth_date")!
        let url = "https://firsttryapi.000webhostapp.com/manage.php?action=update_user&id=\(user_id)&name=\(user_name)&familia=\(user_familia)&otchestvo=\(user_otchestvo)&telephone=\(TelephoneTF.text!)&email=\(emailTF.text!)&birth_date=\(user_birth_date)"
        print(url)
        let update_url = URL(string: url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)

            URLSession.shared.dataTask(with: update_url!, completionHandler: {(data, response, error) in
                guard let data = data, error == nil else {print(error!); return}
                print(data.self)
                let decoder = JSONDecoder()
                let answer = try! decoder.decode(Response.self, from: data)
                print(answer.text)
                if answer.text == "success"{
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(self.TelephoneTF.text, forKey: "user_telephone")
                        UserDefaults.standard.set(self.emailTF.text, forKey: "user_email")
                        self.loadingIndicator.isHidden = true
                        self.UpdateButton.isEnabled = true
                        
                        self.succsessLabel.text = "Изменение сохранено."
                    }
                }else{
                    
                    DispatchQueue.main.async {
                       self.succsessLabel.text = "Прлизошла ошибка при попытке внести изменение."
                    }
                }
            }).resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTF.delegate = self
        TelephoneTF.delegate = self
        FIOlabel.text = UserDefaults.standard.string(forKey: "user_familia")! + " " + UserDefaults.standard.string(forKey: "user_name")! + " " + UserDefaults.standard.string(forKey: "user_otchestvo")!
        emailTF.text = UserDefaults.standard.string(forKey: "user_email")!
        TelephoneTF.text = UserDefaults.standard.string(forKey: "user_telephone")!
        BirthDateLabel.text = UserDefaults.standard.string(forKey: "user_birth_date")!
//        DateTF.inputView = datePicker
//        datePicker.datePickerMode = .date
        
        let numToolBar = UIToolbar()
//        let toolbar = UIToolbar()
        
//        let Loco = Locale.preferredLanguages.first
//        datePicker.locale = Locale(identifier: Loco!)
        
//        toolbar.sizeToFit()
        numToolBar.sizeToFit()
        
        let numDoneButton  = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(numDoneAction))
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(DoneAction))
        let spase = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
//        toolbar.setItems([spase,doneButton], animated: true)
        numToolBar.setItems([spase,numDoneButton], animated: true)
        
//        DateTF.inputAccessoryView = toolbar
        TelephoneTF.inputAccessoryView = numToolBar
        
//        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
//    @objc func DoneAction(){
//        self.view.endEditing(true)
//    }
//
//    @objc func dateChanged(){
//        let formater = DateFormatter()
//        formater.dateFormat = "yyyy-MM-dd"
//        DateTF.text = formater.string(from: datePicker.date)
//    }
    
    @objc func numDoneAction(){
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
}
