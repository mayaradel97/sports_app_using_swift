//
//  LeaguesTableViewController.swift
//  Sports
//
//  Created by MacOSSierra on 2/18/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
class LeaguesTableViewController: UITableViewController
{
    var rowval : Int!
    var videoName:String!
    var sportName :String!
    var leaguesId = [String]()
      var leaguesArray = Array<Dictionary<String, Any>>()
    var leaguesData=Array<Dictionary<String, Any>>()
    override func viewDidLoad()
    {
        super.viewDidLoad()
         
//        print(sportName!)
       /*-------------------------get all leagues id of each sport-------------*/ Alamofire.request("https://www.thesportsdb.com/api/v1/json/1/all_leagues.php").responseJSON(completionHandler: {
            respone in
            if  let json =   respone.result.value as? Dictionary<String,Array<Dictionary<String,Any>>>
            {
                self.leaguesArray=json["leagues"]!
            }
            for i in 0..<self.leaguesArray.count
            {
              let sportValue=self.leaguesArray[i]["strSport"] as! String
                if sportValue == self.sportName{
                    self.leaguesId.append(self.leaguesArray[i]["idLeague"] as! String)
                }
                else
                {
                    self.leaguesId.append("0")
                }
            }
    //    self.tableView.reloadData()
    
        /*-------------------------get data of each leagues-------------*/
        for id in self.leaguesId
        {
            Alamofire.request("https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id=\(id)").responseJSON(completionHandler: {
                respone in
                if  let json =   respone.result.value as? Dictionary<String,Array<Dictionary<String,Any>>>
                {
                    self.leaguesData += json["leagues"]!
                    
                }
                
              self.tableView.reloadData()
            
                
            })
           
        }
        })

       
    }

    
}
