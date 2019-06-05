//
//  ScheduleVC.swift
//  first_try
//
//  Created by Андрей Лихачев on 18/05/2019.
//  Copyright © 2019 Андрей Лихачев. All rights reserved.
//

import UIKit

class ScheduleVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    private var schedule = [Category]()
    private var c = 0
    @IBOutlet weak var SegmentControl: UISegmentedControl!
    @IBOutlet weak var LoadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ScheduleTable: UITableView!
    let url = URL(string: "https://firsttryapi.000webhostapp.com/manage.php?action=get_schedule")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJson()
        
        self.ScheduleTable.dataSource = self
        self.ScheduleTable.delegate = self
    }
    
    @IBAction func CategoryCanched(_ sender: UISegmentedControl) {
        switch SegmentControl.selectedSegmentIndex {
        case 0: c = 0
            DispatchQueue.main.async {
                self.ScheduleTable.reloadData()
            }
        case 1: c = 1
            DispatchQueue.main.async {
                self.ScheduleTable.reloadData()
            }
        case 2: c = 2
            DispatchQueue.main.async {
                self.ScheduleTable.reloadData()
            }
        default:
            c = 0
            DispatchQueue.main.async {
                self.ScheduleTable.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section)
        print(indexPath.row)
        performSegue(withIdentifier: "show_activity", sender: self)
        ScheduleTable.deselectRow(at: indexPath, animated: true)
    }
    
    func downloadJson(){
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else {print(error!); return}
            do
            {
                let decoder = JSONDecoder()
                let categories = try decoder.decode([Category].self, from: data)
                self.schedule = categories
                
            }catch{
                print(error)
            }
            DispatchQueue.main.async {
                self.ScheduleTable.reloadData()
                self.LoadingIndicator.isHidden = true
                self.ScheduleTable.isHidden = false
            }
        }).resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "show_activity"){
            let selectedIndex = self.ScheduleTable.indexPathForSelectedRow
            var day_of_week: String
            var activity: Activity
            switch selectedIndex?.section{
                case 0: day_of_week = self.schedule[c].days_of_week.MON.day_of_week
                case 1: day_of_week = self.schedule[c].days_of_week.TUE.day_of_week
                case 2: day_of_week = self.schedule[c].days_of_week.WED.day_of_week
                case 3: day_of_week = self.schedule[c].days_of_week.THU.day_of_week
                case 4: day_of_week = self.schedule[c].days_of_week.FRI.day_of_week
                case 5: day_of_week = self.schedule[c].days_of_week.SAT.day_of_week
                case 6: day_of_week = self.schedule[c].days_of_week.SUN.day_of_week
            default:
                day_of_week = self.schedule[c].days_of_week.MON.day_of_week
            }
            switch selectedIndex?.section{
                case 0: activity = self.schedule[c].days_of_week.MON.activities[selectedIndex!.row]
                case 1: activity = self.schedule[c].days_of_week.TUE.activities[selectedIndex!.row]
                case 2: activity = self.schedule[c].days_of_week.WED.activities[selectedIndex!.row]
                case 3: activity = self.schedule[c].days_of_week.THU.activities[selectedIndex!.row]
                case 4: activity = self.schedule[c].days_of_week.FRI.activities[selectedIndex!.row]
                case 5: activity = self.schedule[c].days_of_week.SAT.activities[selectedIndex!.row]
                case 6: activity = self.schedule[c].days_of_week.SUN.activities[selectedIndex!.row]
            default:
                activity = self.schedule[c].days_of_week.MON.activities[selectedIndex!.row]
            }
            guard let destinationVC = segue.destination as? ActivityVC else {return}
            destinationVC.title = self.schedule[c].activity_category_name
            destinationVC.activityID = activity.activity_type_id
            destinationVC.activityName = activity.activity_type_name
            destinationVC.day = day_of_week
            destinationVC.length = activity.activity_type_lenth
            let endIndex = activity.start_time.index(activity.start_time.endIndex, offsetBy: -3)
            let start_time = activity.start_time.substring(to: endIndex)
            destinationVC.startTime = start_time
            destinationVC.trainerName = activity.trainer_familia + " " + activity.trainer_name + " " + activity.trainer_otchestvo
            destinationVC.trainerID = activity.trainer_id
            destinationVC.desc = activity.activity_type_description
            if activity.activity_is_paid == "1"{
                destinationVC.isPaid = false
            } else {
                destinationVC.isPaid = true
            }
            if activity.activity_mustbesigned == "1"{
                destinationVC.mustBeSigned = false
            } else {
                destinationVC.mustBeSigned = true
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !self.schedule.isEmpty{
            switch section {
            case 0: return self.schedule[c].days_of_week.MON.activities.count
            case 1: return self.schedule[c].days_of_week.TUE.activities.count
            case 2: return self.schedule[c].days_of_week.WED.activities.count
            case 3: return self.schedule[c].days_of_week.THU.activities.count
            case 4: return self.schedule[c].days_of_week.FRI.activities.count
            case 5: return self.schedule[c].days_of_week.SAT.activities.count
            case 6: return self.schedule[c].days_of_week.SUN.activities.count
            default:
                return 0
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !self.schedule.isEmpty{
            switch section {
            case 0: return self.schedule[c].days_of_week.MON.day_of_week
            case 1: return self.schedule[c].days_of_week.TUE.day_of_week
            case 2: return self.schedule[c].days_of_week.WED.day_of_week
            case 3: return self.schedule[c].days_of_week.THU.day_of_week
            case 4: return self.schedule[c].days_of_week.FRI.day_of_week
            case 5: return self.schedule[c].days_of_week.SAT.day_of_week
            case 6: return self.schedule[c].days_of_week.SUN.day_of_week
            default:
                return "Возкресенье"
            }
        } else {
            return "Возкресенье"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 75
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 65
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell") as! ActivityCell
        cell.StartTimeLabel.text = "\(indexPath.section)"
        cell.LengthLabel.text = "\(indexPath.row)"
        if !self.schedule.isEmpty{
            if !self.schedule.isEmpty{
                switch indexPath.section {
                    
                case 0: cell.ActivityNameLabel.text = self.schedule[c].days_of_week.MON.activities[indexPath.row].activity_type_name
                let endIndex = self.schedule[c].days_of_week.MON.activities[indexPath.row].start_time.index(self.schedule[c].days_of_week.MON.activities[indexPath.row].start_time.endIndex, offsetBy: -3)
                cell.StartTimeLabel.text = self.schedule[c].days_of_week.MON.activities[indexPath.row].start_time.substring(to: endIndex)
                cell.LengthLabel.text = self.schedule[c].days_of_week.MON.activities[indexPath.row].activity_type_lenth + " мин"
                if self.schedule[c].days_of_week.MON.activities[indexPath.row].activity_is_paid == "1"{
                    cell.PaidImage.isHidden = false
                } else {
                    cell.PaidImage.isHidden = true
                }
                if self.schedule[c].days_of_week.MON.activities[indexPath.row].activity_mustbesigned == "1"{
                    cell.SignUpImage.isHidden = false
                } else {
                    cell.SignUpImage.isHidden = true
                    }
                    
                case 1: cell.ActivityNameLabel.text = self.schedule[c].days_of_week.TUE.activities[indexPath.row].activity_type_name
                let endIndex = self.schedule[c].days_of_week.TUE.activities[indexPath.row].start_time.index(self.schedule[c].days_of_week.TUE.activities[indexPath.row].start_time.endIndex, offsetBy: -3)
                cell.StartTimeLabel.text = self.schedule[c].days_of_week.TUE.activities[indexPath.row].start_time.substring(to: endIndex)
                cell.LengthLabel.text = self.schedule[c].days_of_week.TUE.activities[indexPath.row].activity_type_lenth + " мин"
                if self.schedule[c].days_of_week.TUE.activities[indexPath.row].activity_is_paid == "1"{
                    cell.PaidImage.isHidden = false
                } else {
                    cell.PaidImage.isHidden = true
                }
                if self.schedule[c].days_of_week.TUE.activities[indexPath.row].activity_mustbesigned == "1"{
                    cell.SignUpImage.isHidden = false
                } else {
                    cell.SignUpImage.isHidden = true
                    }
                    
                case 2: cell.ActivityNameLabel.text = self.schedule[c].days_of_week.WED.activities[indexPath.row].activity_type_name
                let endIndex = self.schedule[c].days_of_week.WED.activities[indexPath.row].start_time.index(self.schedule[c].days_of_week.WED.activities[indexPath.row].start_time.endIndex, offsetBy: -3)
                cell.StartTimeLabel.text = self.schedule[c].days_of_week.WED.activities[indexPath.row].start_time.substring(to: endIndex)
                cell.LengthLabel.text = self.schedule[c].days_of_week.WED.activities[indexPath.row].activity_type_lenth + " мин"
                if self.schedule[c].days_of_week.WED.activities[indexPath.row].activity_is_paid == "1"{
                    cell.PaidImage.isHidden = false
                } else {
                    cell.PaidImage.isHidden = true
                }
                if self.schedule[c].days_of_week.WED.activities[indexPath.row].activity_mustbesigned == "1"{
                    cell.SignUpImage.isHidden = false
                } else {
                    cell.SignUpImage.isHidden = true
                    }
                    
                case 3: cell.ActivityNameLabel.text = self.schedule[c].days_of_week.THU.activities[indexPath.row].activity_type_name
                let endIndex = self.schedule[c].days_of_week.THU.activities[indexPath.row].start_time.index(self.schedule[c].days_of_week.THU.activities[indexPath.row].start_time.endIndex, offsetBy: -3)
                cell.StartTimeLabel.text = self.schedule[c].days_of_week.THU.activities[indexPath.row].start_time.substring(to: endIndex)
                cell.LengthLabel.text = self.schedule[c].days_of_week.THU.activities[indexPath.row].activity_type_lenth + " мин"
                if self.schedule[c].days_of_week.THU.activities[indexPath.row].activity_is_paid == "1"{
                    cell.PaidImage.isHidden = false
                } else {
                    cell.PaidImage.isHidden = true
                }
                if self.schedule[c].days_of_week.THU.activities[indexPath.row].activity_mustbesigned == "1"{
                    cell.SignUpImage.isHidden = false
                } else {
                    cell.SignUpImage.isHidden = true
                    }
                    
                case 4: cell.ActivityNameLabel.text = self.schedule[c].days_of_week.FRI.activities[indexPath.row].activity_type_name
                let endIndex = self.schedule[c].days_of_week.FRI.activities[indexPath.row].start_time.index(self.schedule[c].days_of_week.FRI.activities[indexPath.row].start_time.endIndex, offsetBy: -3)
                cell.StartTimeLabel.text = self.schedule[c].days_of_week.FRI.activities[indexPath.row].start_time.substring(to: endIndex)
                cell.LengthLabel.text = self.schedule[c].days_of_week.FRI.activities[indexPath.row].activity_type_lenth + " мин"
                if self.schedule[c].days_of_week.FRI.activities[indexPath.row].activity_is_paid == "1"{
                    cell.PaidImage.isHidden = false
                } else {
                    cell.PaidImage.isHidden = true
                }
                if self.schedule[c].days_of_week.FRI.activities[indexPath.row].activity_mustbesigned == "1"{
                    cell.SignUpImage.isHidden = false
                } else {
                    cell.SignUpImage.isHidden = true
                    }
                    
                case 5: cell.ActivityNameLabel.text = self.schedule[c].days_of_week.SAT.activities[indexPath.row].activity_type_name
                let endIndex = self.schedule[c].days_of_week.SAT.activities[indexPath.row].start_time.index(self.schedule[c].days_of_week.SAT.activities[indexPath.row].start_time.endIndex, offsetBy: -3)
                cell.StartTimeLabel.text = self.schedule[c].days_of_week.SAT.activities[indexPath.row].start_time.substring(to: endIndex)
                cell.LengthLabel.text = self.schedule[c].days_of_week.SAT.activities[indexPath.row].activity_type_lenth + " мин"
                if self.schedule[c].days_of_week.SAT.activities[indexPath.row].activity_is_paid == "1"{
                    cell.PaidImage.isHidden = false
                } else {
                    cell.PaidImage.isHidden = true
                }
                if self.schedule[c].days_of_week.SAT.activities[indexPath.row].activity_mustbesigned == "1"{
                    cell.SignUpImage.isHidden = false
                } else {
                    cell.SignUpImage.isHidden = true
                    }
                    
                case 6: cell.ActivityNameLabel.text = self.schedule[c].days_of_week.SUN.activities[indexPath.row].activity_type_name
                let endIndex = self.schedule[c].days_of_week.SUN.activities[indexPath.row].start_time.index(self.schedule[c].days_of_week.SUN.activities[indexPath.row].start_time.endIndex, offsetBy: -3)
                cell.StartTimeLabel.text = self.schedule[c].days_of_week.SUN.activities[indexPath.row].start_time.substring(to: endIndex)
                cell.LengthLabel.text = self.schedule[c].days_of_week.SUN.activities[indexPath.row].activity_type_lenth + " мин"
                if self.schedule[c].days_of_week.SUN.activities[indexPath.row].activity_is_paid == "1"{
                    cell.PaidImage.isHidden = false
                } else {
                    cell.PaidImage.isHidden = true
                }
                if self.schedule[c].days_of_week.SUN.activities[indexPath.row].activity_mustbesigned == "1"{
                    cell.SignUpImage.isHidden = false
                } else {
                    cell.SignUpImage.isHidden = true
                    }
                    
                default:
                    cell.ActivityNameLabel.text = self.schedule[c].days_of_week.MON.activities[indexPath.row].activity_type_name
                    let endIndex = self.schedule[c].days_of_week.MON.activities[indexPath.row].start_time.index(self.schedule[c].days_of_week.MON.activities[indexPath.row].start_time.endIndex, offsetBy: -3)
                    cell.StartTimeLabel.text = self.schedule[c].days_of_week.MON.activities[indexPath.row].start_time.substring(to: endIndex)
                    cell.LengthLabel.text = self.schedule[c].days_of_week.MON.activities[indexPath.row].activity_type_lenth + " мин"
                    if self.schedule[c].days_of_week.MON.activities[indexPath.row].activity_is_paid == "1"{
                        cell.PaidImage.isHidden = false
                    } else {
                        cell.PaidImage.isHidden = true
                    }
                    if self.schedule[c].days_of_week.MON.activities[indexPath.row].activity_mustbesigned == "1"{
                        cell.SignUpImage.isHidden = false
                    } else {
                        cell.SignUpImage.isHidden = true
                    }
                }
            }
        }
        return cell
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
