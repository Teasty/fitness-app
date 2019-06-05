//
//  SingUpTVC.swift
//  first_try
//
//  Created by Андрей Лихачев on 30/05/2019.
//  Copyright © 2019 Андрей Лихачев. All rights reserved.
//

import UIKit

class SingUpTVC: UITableViewController {

    @IBOutlet weak var AnswerLabel: UILabel!
    @IBOutlet weak var TimeLoading: UIActivityIndicatorView!
    @IBOutlet weak var TrainerLoading: UIActivityIndicatorView!
    @IBOutlet weak var TrainerNameField: UITextField!
    @IBOutlet weak var DateField: UITextField!
    @IBOutlet weak var TimeField: UITextField!
    @IBOutlet weak var SignButton: UIButton!
    
    var trainerPickerView = UIPickerView()
    var timePickerView = UIPickerView()
    
    var tariners = [Trainer]()
    var times = [String]()

    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchtrainers()
        trainerPickerView.delegate = self
        trainerPickerView.dataSource = self
        timePickerView.delegate = self
        timePickerView.dataSource = self
        TrainerNameField.inputView = trainerPickerView
        TimeField.inputView = timePickerView
        DateField.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(DoneAction))
        let spase = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spase,doneButton], animated: true)
        DateField.inputAccessoryView = toolbar
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    @objc func DoneAction(){
        self.view.endEditing(true)
        checkfortime()
    }
    
    @objc func dateChanged(){
        let formater = DateFormatter()
        formater.locale = Locale(identifier: "ru_RU")
        formater.dateFormat = "EEEE, d MMM yyyy"
        DateField.text = formater.string(from: datePicker.date)
        TimeField.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkfortime()
        
    }
    
    func checkfortime(){
        DispatchQueue.main.async {
            self.AnswerLabel.text = ""
        }
        if !DateField.text!.isEmpty && !TrainerNameField.text!.isEmpty{
            TimeField.isHidden = true
            TimeLoading.isHidden = false
            print(tariners[trainerPickerView.selectedRow(inComponent: 0)].trainer_id)
            let datepickerFormatter = DateFormatter()
            datepickerFormatter.dateFormat = "yyyy-MM-dd"
            let dayofweek = Calendar(identifier: .gregorian).component(.weekday, from: datePicker.date)
            let selectedDate = datepickerFormatter.string(from: datePicker.date)
            switch dayofweek{
            case 1: fetchtime(trainerid: tariners[trainerPickerView.selectedRow(inComponent: 0)].trainer_id, dayofweek: "SUN", date: selectedDate)
            case 2: fetchtime(trainerid: tariners[trainerPickerView.selectedRow(inComponent: 0)].trainer_id, dayofweek: "MON", date: selectedDate)
            case 3: fetchtime(trainerid: tariners[trainerPickerView.selectedRow(inComponent: 0)].trainer_id, dayofweek: "TUE", date: selectedDate)
            case 4: fetchtime(trainerid: tariners[trainerPickerView.selectedRow(inComponent: 0)].trainer_id, dayofweek: "WED", date: selectedDate)
            case 5: fetchtime(trainerid: tariners[trainerPickerView.selectedRow(inComponent: 0)].trainer_id, dayofweek: "THU", date: selectedDate)
            case 6: fetchtime(trainerid: tariners[trainerPickerView.selectedRow(inComponent: 0)].trainer_id, dayofweek: "FRI", date: selectedDate)
            case 7: fetchtime(trainerid: tariners[trainerPickerView.selectedRow(inComponent: 0)].trainer_id, dayofweek: "SAT", date: selectedDate)
                
            default:fetchtime(trainerid: tariners[trainerPickerView.selectedRow(inComponent: 0)].trainer_id, dayofweek: "SUN", date: selectedDate)
            }
        }
    }
    
    func fetchtrainers(){
        let url = URL(string: "https://firsttryapi.000webhostapp.com/manage.php?action=get_trainers")
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else {print(error!); return}
            do
            {
                let decoder = JSONDecoder()
                let trainers = try decoder.decode([Trainer].self, from: data)
                self.tariners = trainers
                DispatchQueue.main.async {
                    self.TrainerNameField.isHidden = false
                    self.TrainerLoading.isHidden = true
                }
            }catch{
                print(error)
            }
        }).resume()
    }
    
    func fetchtime(trainerid: String, dayofweek: String, date: String){
        let url = URL(string: "https://firsttryapi.000webhostapp.com/manage.php?action=get_times&trainer_id=\(trainerid)&day_of_week=\(dayofweek)&date=\(date)")
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else {print(error!); return}
            print(url!)
            do
            {
                let decoder = JSONDecoder()
                let times = try decoder.decode([String].self, from: data)
                self.times = times
                DispatchQueue.main.async {
                    self.TimeLoading.isHidden = true
                    self.TimeField.isHidden = false
                    self.TimeField.isEnabled = true
                }
            }catch{
                print(error)
            }
        }).resume()
    }
    
    @IBAction func SIgn(_ sender: Any) {
        if !TimeField.text!.isEmpty{
            let datepickerFormatter = DateFormatter()
            datepickerFormatter.dateFormat = "dd-MM-yyyy"
            var start_time = datepickerFormatter.string(from: datePicker.date) + "-" + TimeField.text!
            datepickerFormatter.dateFormat = "dd-MM-yyyy-HH:mm"
            print(start_time)
            let new_time = datepickerFormatter.date(from: start_time)!
            datepickerFormatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
            start_time = datepickerFormatter.string(from: new_time)
            let interval:TimeInterval = 60*60
            let new_time1 = Date(timeInterval: interval, since: new_time)
            datepickerFormatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
            let end_time = datepickerFormatter.string(from: new_time1)
            print(start_time)
            let user_id = UserDefaults.standard.string(forKey: "user_id")!
            let url = "https://firsttryapi.000webhostapp.com/manage.php?action=register&activity_type_id=90&start_date_time=\(start_time)&end_date_time=\(end_time)&trainer_id=\(tariners[trainerPickerView.selectedRow(inComponent: 0)].trainer_id)&client_id=\(user_id)"

            let Url = URL(string: url)
            URLSession.shared.dataTask(with: Url!, completionHandler: {(data, response, error) in
                guard let data = data, error == nil else {print(error!); return}


                let decoder = JSONDecoder()
                let answer = try! decoder.decode(ActivityVC.Response.self, from: data)

                if answer.response == "success"{
                    DispatchQueue.main.async {
                        self.AnswerLabel.text = "Вы были записаны."
                    }
                }else{
                    DispatchQueue.main.async {
                        self.AnswerLabel.text = answer.start_time + "'" + answer.activity_name + "'"
                    }
                }

            }).resume()
            checkfortime()
        }
    }
    
    
}

extension SingUpTVC: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == trainerPickerView{
            return tariners.count
        } else if pickerView == timePickerView{
            return times.count
        } else{
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == trainerPickerView{
            return tariners[row].trainer_familia + " " + tariners[row].trainer_name + " " + tariners[row].trainer_otchestvo
        } else if pickerView == timePickerView{
            return times[row]
        } else{
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == trainerPickerView{
            self.TrainerNameField.text = tariners[row].trainer_familia + " " + tariners[row].trainer_name + " " + tariners[row].trainer_otchestvo
            self.view.endEditing(true)
            TimeField.isEnabled = false
            checkfortime()
        } else if pickerView == timePickerView{
            TimeField.text = times[row]
            self.view.endEditing(true)
        }
    }
}
