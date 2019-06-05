//
//  ScheduleModels.swift
//  first_try
//
//  Created by Андрей Лихачев on 18/05/2019.
//  Copyright © 2019 Андрей Лихачев. All rights reserved.
//

import Foundation
import UIKit

class Activity: Codable {
    let activity_type_id: String
    let trainer_id: String
    let start_time: String
    let activity_type_category_id: String
    let activity_type_name: String
    let activity_type_description: String
    let activity_type_lenth: String
    let activity_is_paid: String
    let activity_mustbesigned: String
    let trainer_name: String
    let trainer_familia: String
    let trainer_otchestvo: String
    let trainer_telephone: String
    let trainer_email: String
}

class Day: Codable{
    let day_of_week: String
    let activities: [Activity]
}

class Category: Codable{
    let activity_category_name: String
    let activity_category_id:  String
    let activity_category_color: String
    let activity_category_description: String
    let days_of_week: Week
}

class Week: Codable {
    let MON: Day
    let TUE: Day
    let WED: Day
    let THU: Day
    let FRI: Day
    let SAT: Day
    let SUN: Day
}

class Register: Codable{
    let activity_type_name: String
    let start_date_time: String
    let activity_type_lenth: String
    let time: String
}

class Trainer: Codable{
    let trainer_id: String
    let trainer_name: String
    let trainer_familia: String
    let trainer_otchestvo: String
}
