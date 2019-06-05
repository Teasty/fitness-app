//
//  RefreshTVC.swift
//  first_try
//
//  Created by Андрей Лихачев on 30/05/2019.
//  Copyright © 2019 Андрей Лихачев. All rights reserved.
//

import UIKit

class RefreshTVC: UITableViewController {
    @IBOutlet weak var AlertLabel: UILabel!
    @IBOutlet weak var CardTypeTextField: UITextField!
    @IBOutlet weak var AbonrmrntSwitch: UISwitch!
    @IBOutlet weak var CardNumberTextField: UITextField!
    @IBOutlet weak var NewClientSwitch: UISwitch!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var FamiliaTextField: UITextField!
    @IBOutlet weak var OtchestvoField: UITextField!
    @IBOutlet weak var BirthDayField: UITextField!
    @IBOutlet weak var EmailTExtField: UITextField!
    @IBOutlet weak var TelephoneField: UITextField!
    @IBOutlet weak var CardsLoading: UIActivityIndicatorView!
    
    
    var cards = [String]()
    var cardPicker = UIPickerView()
    var birthdayPicker = UIDatePicker()
    
    
    let numToolBar = UIToolbar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchcards()
        cardPicker.delegate = self
        cardPicker.dataSource = self
        BirthDayField.inputView = birthdayPicker
        CardTypeTextField.inputView = cardPicker
        birthdayPicker.datePickerMode = .date
        birthdayPicker.locale = Locale(identifier: "ru_RU")
        birthdayPicker.minimumDate = Calendar.current.date(byAdding: .year, value: -80, to: Date())
        birthdayPicker.maximumDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(DoneAction))
        let spase = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spase,doneButton], animated: true)
        BirthDayField.inputAccessoryView = toolbar
        birthdayPicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        numToolBar.sizeToFit()
        let numDoneButton  = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(numDoneAction))
        let spase1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        numToolBar.setItems([spase1,numDoneButton], animated: true)
        TelephoneField.inputAccessoryView = numToolBar
        CardNumberTextField.inputAccessoryView = numToolBar
    }
    
    @objc func numDoneAction(){
        self.view.endEditing(true)
    }
    
    @objc func DoneAction(){
        self.view.endEditing(true)
    }
    
    @objc func dateChanged(){
        let formater = DateFormatter()
        formater.locale = Locale(identifier: "ru_RU")
        formater.dateFormat = "d MMM yyyy"
        BirthDayField.text = formater.string(from: birthdayPicker.date)
    }

    @IBAction func AbonementSwitched(_ sender: Any) {
        NewClientSwitch.setOn(false, animated: true)
        
    }
    @IBAction func NewClientSwitched(_ sender: Any) {
        AbonrmrntSwitch.setOn(false, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 4 && indexPath.row == 0{
            
            if !CardTypeTextField.text!.isEmpty && AbonrmrntSwitch.isOn{
                purchase_via_card()
            }else if !CardTypeTextField.text!.isEmpty && NewClientSwitch.isOn{
                purchase_via_user_info()
            } else{
                show_warning(message: "Выберите вид карты и способ авторизации")
            }
            
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func purchase_via_card() {
        if !CardNumberTextField.text!.isEmpty && CardNumberTextField.text!.count <= 8{
            let card_number = CardNumberTextField.text!
            let string = "https://firsttryapi.000webhostapp.com/manage.php?action=refresh_via_card&card_type=\(CardTypeTextField.text!)&card_number=\(card_number)"
            let new_string = string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            
            let url = URL(string:new_string)
            URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
                guard let data = data, error == nil else {print(error!); return}
                do
                {
                    let decoder = JSONDecoder()
                    let answer = try decoder.decode([String].self, from: data)
                    if answer[0] == "success"{
                        print("udachno")
                        self.login(card_number: answer[1])
                    }else{
                        self.show_warning(message: answer[0])
                    }
                }catch{
                    print(error)
                }
            }).resume()
        } else {
            show_warning(message: "Введите корректные данные вышего предыдущего абонемента")
        }
    }
    
    func purchase_via_user_info() {
        show_warning(message: "")
         if !NameTextField.text!.isEmpty && !FamiliaTextField.text!.isEmpty && !OtchestvoField.text!.isEmpty && !BirthDayField.text!.isEmpty && !EmailTExtField.text!.isEmpty && !TelephoneField.text!.isEmpty && string_contain_only_letters(str: NameTextField.text!) && string_contain_only_letters(str: FamiliaTextField.text!) && string_contain_only_letters(str: OtchestvoField.text!) && TelephoneField.text!.count >= 10 {
            let formater = DateFormatter()
            formater.dateFormat = "yyyy-MM-dd"
            let b_date = formater.string(from: birthdayPicker.date)
            
            let string = "https://firsttryapi.000webhostapp.com/manage.php?action=refresh_via_new_user&card_type=\(CardTypeTextField.text!)&client_name=\(NameTextField.text!)&client_familia=\(FamiliaTextField.text!)&client_otchestvo=\(OtchestvoField.text!)&client_telephone=\(TelephoneField.text!)&client_email=\(EmailTExtField.text!)&client_birth_day=\(b_date)"
            let new_string = string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            
            let url = URL(string:new_string)
            URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
                guard let data = data, error == nil else {print(error!); return}
                print(url!)
                do
                {
                    let decoder = JSONDecoder()
                    let answer = try decoder.decode([String].self, from: data)
                    if answer[0] == "success"{
                        print("udachno")
                        self.login(card_number: answer[1])
                    }else{
                        self.show_warning(message: answer[0])
                    }
                }catch{
                    print(error)
                    self.show_warning(message: "Возникли проблемы на сервере. Проверьте корректность введенных данных или повторите попытку через некоторое время.")
                }
            }).resume()
         }else{
            show_warning(message: "Введите корректыне данные для регистрации нового пользователя.")
        }
    }
    
    func show_warning(message: String){
        let indexPath = NSIndexPath(row: 1, section: 4)
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: indexPath as IndexPath,at: UITableView.ScrollPosition.middle, animated: true)
            self.AlertLabel.text = message
        }
    }
    
    func fetchcards(){
        let url = URL(string: "https://firsttryapi.000webhostapp.com/manage.php?action=get_cards")
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else {print(error!); return}
            do
            {
                let decoder = JSONDecoder()
                let cards = try decoder.decode([String].self, from: data)
                self.cards = cards
                DispatchQueue.main.async {
                    self.CardTypeTextField.isHidden = false
                    self.CardsLoading.isHidden = true
                }
            }catch{
                print(error)
            }
        }).resume()
    }
    
    func login(card_number: String){
        let url = URL(string: "https://firsttryapi.000webhostapp.com/manage.php?action=login_via_card&card_number=\(card_number)")
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else {print(error!); return}
            
            let decoder = JSONDecoder()
            let answer = try! decoder.decode(LogInVC.Response.self, from: data)
            
            if answer.text == "access_granted"{
                UserDefaults.standard.setUser(id: answer.client_id, name: answer.client_name, familia: answer.client_familia, otchestvo: answer.client_otchestvo, telephone: answer.client_telephone, email: answer.client_email, birth_date: answer.client_birth_date)
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "register", sender: self)
                }
            } else{
                
                DispatchQueue.main.async {
                    self.show_warning(message: answer.text)
                }
            }
            
            
            
        }).resume()
    }
    
    func string_contain_only_letters(str: String) -> Bool {
        for chr in str {
            if (!(chr >= "а" && chr <= "я") && !(chr >= "А" && chr <= "Я") && !(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && !(chr == " ") ) {
                return false
            }
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension RefreshTVC:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cards.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cards[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        CardTypeTextField.text = cards[row]
        self.view.endEditing(true)
    }
    
}

extension RefreshTVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
}
