//
//  FavoritesTableViewController.swift
//  Sports
//
//  Created by MacOSSierra on 2/23/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData
class FavoritesTableViewController: UITableViewController
{
  
    var leagueVideo:String!
    var leaguesArray = [NSManagedObject]()
    var rowValue:Int!
  
    @IBAction func videoButton(_ sender: Any)
    {
     navigateToYoutubeView()
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

    self.navigationItem.rightBarButtonItem?.customView?.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool)
    {
        //fetch favorites from core data
       self.fetchLeagues()
    }

    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesArray.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoritesTableViewCell
         cell.leagueNameLabel?.text=leaguesArray[indexPath.row].value(forKey: "name") as? String
        //check eny m7othash aslan fe el core data lw hya nil
       let str = leaguesArray[indexPath.row].value(forKey: "image") as? String
        if str==nil
        {
            cell.leagueImage.image=UIImage(named: "loading")
        }
        else{
            cell.leagueImage?.sd_setImage(with: URL(string:str!), placeholderImage: UIImage(named: "loading"))}
        cell.leagueImage?.layer.borderWidth = 1
        cell.leagueImage?.layer.borderColor = UIColor.black.cgColor
        cell.leagueImage?.layer.cornerRadius = ((cell.leagueImage?.frame.width)! / 2)
        cell.leagueImage?.clipsToBounds = true
        leagueVideo=leaguesArray[indexPath.row].value(forKey: "video") as? String
    //    print("fav\(leaguesArray[indexPath.row].value(forKey: "video") as? String)")
        cell.leagueNameLabel.sizeToFit()

        return cell
    }

}
