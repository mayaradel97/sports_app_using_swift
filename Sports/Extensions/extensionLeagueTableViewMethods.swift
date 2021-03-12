//
//  extensionLeagueTableViewMethods.swift
//  Sports
//
//  Created by MacOSSierra on 3/7/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import Foundation
import UIKit
extension LeaguesTableViewController
{
    // MARK: - Table view data source
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeaguesTableViewCell
        cell.leagueNameLabel.adjustsFontSizeToFitWidth = false
        
        /*---------------rounded image--------------*/
        if leaguesData[indexPath.row][  "strBadge"]  is NSNull
        {
                cell.leagueImage.image=UIImage(named: "loading")
        }
        else{
        let str=(leaguesData[indexPath.row][  "strBadge"] as! String)
    
        cell.leagueImage?.sd_setImage(with: URL(string:str), placeholderImage: UIImage(named: "loading"))
        }
        cell.leagueImage?.layer.borderWidth = 1
        cell.leagueImage?.layer.borderColor = UIColor.black.cgColor
        cell.leagueImage?.layer.cornerRadius = ((cell.leagueImage?.frame.width)! / 2)
        cell.leagueImage?.clipsToBounds = true
        cell.leagueNameLabel?.text=(leaguesData[indexPath.row]["strLeague"] as! String)
        //save index row to get video link
        cell.videoButtonOutlet.tag=indexPath.row
        cell.videoButtonOutlet.addTarget(self, action: #selector(navToYoutube), for: .touchUpInside)
     
        //rounded cell
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    //segue  to youtube view when press video button
    @objc func navToYoutube(sender:UIButton)
    {
        let index=IndexPath(row: sender.tag, section: 0)
        videoName =  leaguesData[index.row]["strYoutube"] as? String
        UIApplication.shared.open(URL(string: "https://\(videoName!)")!, options: [:], completionHandler: nil)
      
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leaguesDetails=self.storyboard?.instantiateViewController(withIdentifier: "leaguesDetails") as! LeaguesDetailsViewController
  //      print(leaguesData[indexPath.row]["idLeague"] as? String? as Any)
        leaguesDetails.leagueId = leaguesData[indexPath.row]["idLeague"] as? String
        leaguesDetails.leagueName = leaguesData[indexPath.row]["strLeague"] as? String
        leaguesDetails.leagueImage = leaguesData[indexPath.row]["strBadge"] as? String
        leaguesDetails.leagueVideo = leaguesData[indexPath.row]["strYoutube"] as? String
        rowval=indexPath.row
    
        //make navigation bar  when present details view
        
        let navDetailsViewController: UINavigationController = UINavigationController(rootViewController: leaguesDetails)
        self.present(navDetailsViewController, animated: true, completion: nil)
        
    }

}
