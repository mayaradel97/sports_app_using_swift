//
//  LeaguesDetailsViewController.swift
//  Sports
//
//  Created by MacOSSierra on 2/20/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
class LeaguesDetailsViewController: UITableViewController,UICollectionViewDataSource,UICollectionViewDelegate

{
    //row value

    //check fav button
         var isfav:Bool=true
    //collection view outlits
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    @IBOutlet weak var resultsCollectionView: UICollectionView!
    @IBOutlet weak var eventsCollectionView: UICollectionView!
    //get the league id from league table view to get the details of this league using id
    var leagueId:String!
    //get the leagues name and image from league table viewand store them in core data
    var leagueName:String!
    var leagueImage:String!
     var leagueVideo:String!
    //favorite image variable to change the image when pressed the fav button
    var favImage:String!
    //favorite right button item
    var favButton :UIBarButtonItem!
    //get the data from api and store them in array
    var eventsArray = Array<Dictionary<String,Any>>()
      var teamsArray = Array<Dictionary<String,Any>>()
   //check if its from favview to colored fav button
    var isFavView:Bool = false
 //create reference from protocol to delete fav
    var favDelegate:favProtocol!
  

    override func viewDidLoad()
    {

     
        super.viewDidLoad()
            /*-------------------------Favorite button---------------------*/
        if isFavView
        {
            favImage = "favoriteFill"
           // isfav=true
            favButton  = UIBarButtonItem(
                image: UIImage(named: favImage)?.withRenderingMode(.alwaysTemplate),
                style: .done, target: self, action: #selector(favClick(sender:)))
            self.navigationItem.setRightBarButton(favButton , animated: true)
            favImage="fav"
            isfav=false
        }
        else{
            favImage = "fav"
            isfav=false
            favButton  = UIBarButtonItem(
                image: UIImage(named: favImage)?.withRenderingMode(.alwaysTemplate),
                style: .done, target: self, action: #selector(favClick(sender:)))
            self.navigationItem.setRightBarButton(favButton , animated: true)
            favImage="favoriteFill"
            isfav=true
        }
         //call custom back button from extension leagues details
         self.backButton()

         /*---------------------------Events  api------------------------*/
        Alamofire.request("https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id=\(leagueId!)").responseJSON(completionHandler: {
            respone in
            if  let json =   respone.result.value as? Dictionary<String,Array<Dictionary<String,Any>>>
            {
                self.eventsArray=json["events"]!
                
            }
            
            
          self.eventsCollectionView.reloadData()
             self.resultsCollectionView.reloadData()
            
        })
         /*---------------------------Teams api------------------------*/
        
        Alamofire.request("https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=\(leagueId!)").responseJSON(completionHandler: {
            respone in
            if  let json =   respone.result.value as? Dictionary<String,Array<Dictionary<String,Any>>>
            {
                self.teamsArray=json["teams"]!
             
            }
            
            
            self.teamsCollectionView.reloadData()
        
            
        })
    }


 
 
}
