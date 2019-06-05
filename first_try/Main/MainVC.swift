//
//  MainVC.swift
//  first_try
//
//  Created by Андрей Лихачев on 26/05/2019.
//  Copyright © 2019 Андрей Лихачев. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var PostsCollectionView: UICollectionView!
    @IBOutlet weak var RegistersTable: UITableView!
    @IBOutlet weak var YesButton: UIButton!
    @IBOutlet var MessageView: UIView!
    
    var posts = [Post]()
    var activities = [Register]()
    var time = String()
    var k = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PostsCollectionView.dataSource = self
        PostsCollectionView.delegate = self
        RegistersTable.dataSource = self
        RegistersTable.delegate = self
        RegistersTable.tableFooterView = UIView(frame: .zero)
        fetch_postc()
        fetch_registers()
        PostsCollectionView.reloadData()
        MessageView.layer.cornerRadius = 25
        // Do any additional setup after loading the view.
    }
    
    func fetch_postc(){
        let url = URL(string: "https://firsttryapi.000webhostapp.com/manage.php?action=get_posts")
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else {print(error!); return}
            do
            {
                let decoder = JSONDecoder()
                let posts = try decoder.decode([Post].self, from: data)
                self.posts = posts
                DispatchQueue.main.async {
                    self.PostsCollectionView.reloadData()
                }
            }catch{
                print(error)
            }
        }).resume()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetch_registers()
        fetch_postc()
    }
    
    func fetch_registers(){
        let user_id = UserDefaults.standard.string(forKey: "user_id")!
        let url = URL(string: "https://firsttryapi.000webhostapp.com/manage.php?action=get_registers&client_id=\(user_id)")
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else {print(error!); return}
            do
            {
                let decoder = JSONDecoder()
                let activities = try decoder.decode([Register].self, from: data)
                self.activities = activities
                DispatchQueue.main.async {
                    self.RegistersTable.reloadData()
                }
            }catch{
                print(error)
            }
        }).resume()
    }
    
    func delete() {
        
        let newtime = time.replacingOccurrences(of: " ", with: "-", options: .literal, range: nil)
        let user_id = UserDefaults.standard.string(forKey: "user_id")!
        let url = URL(string: "https://firsttryapi.000webhostapp.com/manage.php?action=delete_register&client_id=\(user_id)&time=\(newtime)")
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else {print(error!); return}
        }).resume()
    }
    
    func showpopup(){
        self.view.addSubview(MessageView)
        MessageView.center = self.view.center
    }
    @IBAction func yespopup(_ sender: Any) {
        self.activities.remove(at: k)
        RegistersTable.reloadData()
        delete()
        self.MessageView.removeFromSuperview()
    }
    
    @IBAction func closepopup(_ sender: Any) {
        self.MessageView.removeFromSuperview()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "show_post"){
            guard let destinationVC = segue.destination as? PostVC else {return}
            let postIndex = PostsCollectionView.indexPathsForSelectedItems
            destinationVC.ptitle = posts[(postIndex?.first?.item)!].post_title
            destinationVC.text = posts[(postIndex?.first?.item)!].post_text
        }
    }
}

extension MainVC: UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.item]
        cell.post = post
        return cell
    }
}

extension MainVC: UIScrollViewDelegate, UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "show_post", sender: self)
    }
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let layout = self.PostsCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
//        let cellwithspacing = layout.itemSize.width + layout.minimumLineSpacing
//
//        var offset = targetContentOffset.pointee
//        let index = (offset.x + scrollView.contentInset.left) / cellwithspacing
//        let roundIndex = round(index)
//
//        offset = CGPoint(x: roundIndex + cellwithspacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
//
//        targetContentOffset.pointee = offset
//    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterCell") as! RegisterCell
        cell.ActivityNameLabel.text = activities[indexPath.row].activity_type_name
        cell.StartTimeLabel.text = activities[indexPath.row].start_date_time
        cell.LengthLabel.text = activities[indexPath.row].activity_type_lenth + " мин"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            time = activities[indexPath.row].time
            k = indexPath.row
            showpopup()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Отказаться от занятия"
    }
    
}
