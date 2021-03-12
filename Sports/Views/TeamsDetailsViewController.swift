//
//  TeamsDetailsViewController.swift
//  Sports
//
//  Created by MacOSSierra on 2/25/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit
import  SDWebImage
import Alamofire
class TeamsDetailsViewController: UITableViewController
{
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamDescription: UITextView!
    @IBOutlet weak var teamName: UILabel!
    var teamId:String!
    var teamDetailsArray = Array<Dictionary<String,Any>>()
    var fb:String! ,twitter:String! ,instagram :String!
    override func viewDidLoad()
    {

        super.viewDidLoad()
       /*---------fetch team details ----------------*/ Alamofire.request("https://www.thesportsdb.com/api/v1/json/1/lookupteam.php?id=\(teamId ?? "")").responseJSON(completionHandler: {

            respone in
            if  let json =   respone.result.value as? Dictionary<String,Array<Dictionary<String,Any>>>
            {
                self.teamDetailsArray=json["teams"]!
                self.teamName.text=(self.teamDetailsArray[0]["strTeam"] as! String)
                self.teamImage.sd_setImage(with: URL(string:self.teamDetailsArray[0]["strTeamBadge"] as! String), placeholderImage: UIImage(named: "loading"))
                if self.teamDetailsArray[0]["strDescriptionEN"]  is NSNull
                {
                     self.teamDescription.text = ""
                }
                else{
                    self.teamDescription.text = (self.teamDetailsArray[0]["strDescriptionEN"] as! String)
                    
                }
                //get fb,twitter and instagram link to navigate to webview
                self.fb = (self.teamDetailsArray[0]["strFacebook"] as! String)
               self.twitter = (self.teamDetailsArray[0]["strTwitter"] as! String)
               self.instagram = (self.teamDetailsArray[0]["strInstagram"] as! String)
                self.teamImage.layer.borderWidth = 1
                self.teamImage.layer.borderColor = UIColor.black.cgColor
                self.teamImage.layer.cornerRadius = ((self.teamImage.frame.width) / 2)
                self.teamImage.clipsToBounds = true
            }
            
        })

   
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let videoView=segue.destination as! YoutubeViewController
        switch segue.identifier {
   
            //when press fb button
        case "facebook": videoView.videoName=fb
                //when press twitter button
        case "twitter":videoView.videoName=twitter
                //when press instagram button
        case "instagram":videoView.videoName=instagram
        default:
            print("no link")
        }
    }
    
    

}
