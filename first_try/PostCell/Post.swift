//
//  Post.swift
//  first_try
//
//  Created by Андрей Лихачев on 26/05/2019.
//  Copyright © 2019 Андрей Лихачев. All rights reserved.
//

import UIKit

class Post: Codable
{
    let post_title: String
    let post_short_desc: String
    let post_text: String
    
    static func fetch_postc() -> [Post]{
        var result = [Post]()
        let url = URL(string: "https://firsttryapi.000webhostapp.com/manage.php?action=get_registers")
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else {print(error!); return}
            do
            {
                let decoder = JSONDecoder()
                let posts = try decoder.decode([Post].self, from: data)
                result = posts
            }catch{
                print(error)
            }
        }).resume()
        return result
    }
}
