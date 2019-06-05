//
//  ActivityVC.swift
//  first_try
//
//  Created by Андрей Лихачев on 19/05/2019.
//  Copyright © 2019 Андрей Лихачев. All rights reserved.
//

import UIKit

class ActivityVC: UIViewController {

    @IBOutlet weak var ActivityNameLabel: UILabel!
    @IBOutlet weak var StartTimeLabel: UILabel!
    @IBOutlet weak var PaidImage: UIImageView!
    @IBOutlet weak var SingImage: UIImageView!
    @IBOutlet weak var LengthLabel: UILabel!
    @IBOutlet weak var DayOfWeekLabel: UILabel!
    @IBOutlet weak var TrainerNameLabel: UILabel!
    @IBOutlet weak var ActivityDescriptionText: UITextView!
    @IBOutlet weak var SignButton: UIButton!
    
    @IBOutlet weak var AnswerLabel: UILabel!
    
    struct Response: Codable {
        let response: String
        let activity_name: String
        let start_time: String
        
    }
    
    var activityID: String?
    var activityName: String?
    var startTime: String?
    var day: String?
    var length: String?
    var trainerName: String?
    var isPaid: Bool?
    var mustBeSigned: Bool?
    var desc: String?
    var trainerID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ActivityNameLabel.text = activityName!
        StartTimeLabel.text = "Начало в " + startTime!
        DayOfWeekLabel.text = day!
        LengthLabel.text = length! + " мин"
        TrainerNameLabel.text = trainerName!
        ActivityDescriptionText.text = desc!
        SingImage.isHidden = mustBeSigned!
        PaidImage.isHidden = isPaid!
        SignButton.isHidden = mustBeSigned!
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sign(_ sender: UIButton) {
        singup(start_time: startTime!, length: length!, activity_id: activityID!, trainer_id: trainerID!, alert_label: AnswerLabel)
    }
    
    
    func singup(start_time: String, length: String, activity_id: String, trainer_id: String, alert_label: UILabel){
        let nextdate = getStartEndtime(starttime: start_time, length: length)
        let user_id = UserDefaults.standard.string(forKey: "user_id")!
        let url = "https://firsttryapi.000webhostapp.com/manage.php?action=register&activity_type_id=\(activity_id)&start_date_time=\(nextdate[0])&end_date_time=\(nextdate[1])&trainer_id=\(trainer_id)&client_id=\(user_id)"
        
        let Url = URL(string: url)
        print(url)
        URLSession.shared.dataTask(with: Url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else {print(error!); return}
            
            
            let decoder = JSONDecoder()
            let answer = try! decoder.decode(Response.self, from: data)
            
            if answer.response == "success"{
                DispatchQueue.main.async {
                    alert_label.text = "Вы были записаны."
                }
            }else{
                DispatchQueue.main.async {
                    alert_label.text = answer.start_time + "'" + answer.activity_name + "'"
                }
            }
            
        }).resume()
    }
    
    func getStartEndtime(starttime: String, length: String) -> [String] {
        let timearr = starttime.components(separatedBy: ":")
        let calendar = Calendar.current
        var nextDay = DateComponents()
        let dateFormatter = DateFormatter()
        switch day {
        case "Понедельник": nextDay.weekday = 2
        case "Вторник": nextDay.weekday = 3
        case "Среда": nextDay.weekday = 4
        case "Четверг": nextDay.weekday = 5
        case "Пятница": nextDay.weekday = 6
        case "Суббота": nextDay.weekday = 7
        case "Воскресенье": nextDay.weekday = 1
        default:
            nextDay.weekday = 1
        }
        print(timearr[0], timearr[1])
        nextDay.hour = Int(timearr[0])
        nextDay.minute = Int(timearr[1])
        let result = calendar.nextDate(after: Date(), matching: nextDay, matchingPolicy: .nextTime)
        print(result!)
        dateFormatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        let new_start_time = dateFormatter.string(from: result!)
        print(new_start_time)
        let interval:TimeInterval = Double(length)!*60
        let end_time = Date(timeInterval: interval, since: result!)
        let new_end_time = dateFormatter.string(from: end_time)
        return [new_start_time, new_end_time]
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
