//
//  CardInfoVC.swift
//  first_try
//
//  Created by Андрей Лихачев on 08/05/2019.
//  Copyright © 2019 Андрей Лихачев. All rights reserved.
//

import Foundation
import UIKit

class CardInfoVC: UIViewController {
    
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var NameField: UILabel!
    @IBOutlet weak var DescLabel: UILabel!
    @IBOutlet weak var DescField: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var TimeField: UILabel!
    @IBOutlet weak var LeftLabel: UILabel!
    @IBOutlet weak var LeftField: UILabel!
    @IBOutlet weak var LoadingIndicator: UIActivityIndicatorView!
    
    struct Response: Codable {
        let card_number: String
        let start_date: String
        let name: String
        let description: String
        let end_date: String
        enum CodingKeys:String, CodingKey {
            case card_number = "card_number"
            case start_date = "start_date"
            case name = "name"
            case description = "description"
            case end_date = "end_date"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user_id = UserDefaults.standard.string(forKey: "user_id")!
        let url = "https://firsttryapi.000webhostapp.com/manage.php?action=card_info&id=\(user_id)"
        let update_url = URL(string: url)
        URLSession.shared.dataTask(with: update_url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else {print(error!); return}
            let decoder = JSONDecoder()
            let answer = try! decoder.decode(Response.self, from: data)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let start_date = dateFormatter.date(from: answer.start_date)
            let end_date = dateFormatter.date(from: answer.end_date)
            
            let formater = DateFormatter()
            formater.dateFormat = "dd MMM yyyy"
            
            DispatchQueue.main.async {
                self.NameField.text = answer.name
                self.DescField.text = answer.description
                self.TimeField.text = formater.string(from: start_date!) + " - " + formater.string(from: end_date!)
                self.LeftField.text = "\(Calendar.current.dateComponents([.day], from: Date.init(), to: end_date!).day!) дней"
            }
            self.HideLoading()
        }).resume()
    }
    
    func HideLoading(){
        DispatchQueue.main.async {
            self.LoadingIndicator.stopAnimating()
            self.NameLabel.isHidden = false
            self.NameField.isHidden = false
            self.DescLabel.isHidden = false
            self.DescField.isHidden = false
            self.TimeLabel.isHidden = false
            self.TimeField.isHidden = false
            self.LeftLabel.isHidden = false
            self.LeftField.isHidden = false
        }
    }
    
}
