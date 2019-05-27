//
//  UserDefaults+helper.swift
//  first_try
//
//  Created by Андрей Лихачев on 23/04/2019.
//  Copyright © 2019 Андрей Лихачев. All rights reserved.
//

import Foundation

extension UserDefaults{
    
    func setUser(id:String, name:String, familia:String, otchestvo:String, telephone:String, email:String, birth_date:String) {
        set(id, forKey: "user_id")
        set(name, forKey: "user_name")
        set(familia, forKey: "user_familia")
        set(otchestvo, forKey: "user_otchestvo")
        set(telephone, forKey: "user_telephone")
        set(email, forKey: "user_email")
        set(birth_date, forKey: "user_birth_date")
        synchronize()
    }
    
    func deleteUserId() {
        set(nil, forKey: "user_id")
        set(nil, forKey: "user_name")
        synchronize()
    }
    
    func isLogedIn() -> Bool {
        if string(forKey: "user_id") != nil && string(forKey: "user_name") != nil && string(forKey: "user_familia") != nil && string(forKey: "user_otchestvo") != nil && string(forKey: "user_telephone") != nil && string(forKey: "user_email") != nil{
            return true
        }else{
            return false
        }
    }
    
}
