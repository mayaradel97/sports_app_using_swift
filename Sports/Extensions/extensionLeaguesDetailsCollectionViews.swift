//
//  extensionLeaguesDetailsCollectionViews.swift
//  Sports
//
//  Created by MacOSSierra on 2/23/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import Foundation
import UIKit
extension LeaguesDetailsViewController
{
    
    /*--------------------------custom back button-------------------*/
    func backButton()
    {
        let btnLeftMenu: UIButton = UIButton()
        let image = UIImage(named: "back")
        let tintedImage = image!.withRenderingMode(.alwaysTemplate)
        btnLeftMenu.setImage(tintedImage, for: .normal)
        btnLeftMenu.setTitle("Back", for: .normal);
        btnLeftMenu.titleLabel?.font = UIFont(name: "Didot", size: 30.0)
        btnLeftMenu.tintColor = self.view.tintColor;
        btnLeftMenu.setTitleColor(self.view.tintColor, for: .normal)
        btnLeftMenu.sizeToFit()
        btnLeftMenu.addTarget(self, action: Selector(("back")), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        navigationController?.view.tintColor = self.view.tintColor
        self.navigationItem.leftBarButtonItem = barButton
    }
    @objc func back()
    {
        
        self.dismiss(animated: true, completion: nil)
        
    }
        /*--------------------------collection view functions-------------------*/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case eventsCollectionView,resultsCollectionView:return eventsArray.count
       // case resultsCollectionView:  return eventsArray.count
        case teamsCollectionView:return teamsArray.count
        default:
            return 0;
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        /*--------------------------events collection view-------------------*/
        let eventsCell = eventsCollectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventsCollectionViewCell
        if collectionView == eventsCollectionView
        {
           eventsCell .eventNameLabel?.text=eventsArray[indexPath.row]["strEvent"] as? String
            //check if api contain null data
            if ( eventsArray[indexPath.row]["dateEvent"] is  NSNull) || (eventsArray[indexPath.row]["strTime"] is NSNull)
            {
                eventsCell .eventDateLabel?.text = "no date"
            }else
            {
           eventsCell .eventDateLabel?.text = (eventsArray[indexPath.row]["dateEvent"]as? String)! + " AT " +  (eventsArray[indexPath.row]["strTime"] as? String)!
            }
            //make labels fit the content
            eventsCell .eventNameLabel?.adjustsFontSizeToFitWidth = true
           eventsCell .eventDateLabel?.adjustsFontSizeToFitWidth = true
            //make corner radius to collection view
            eventsCollectionView.layer.cornerRadius=25
            //make corener radius to the cell
            eventsCell .layer.cornerRadius=30
            return eventsCell
        }

       /*--------------------------results collection view-------------------*/
        if collectionView == resultsCollectionView
        {
            let resultsCell = resultsCollectionView.dequeueReusableCell(withReuseIdentifier: "resultCell", for: indexPath) as! ResultsCollectionViewCell
            resultsCell.homeTeamName?.text =
                eventsArray[indexPath.row]["strHomeTeam"] as? String
           resultsCell.awayTeamName?.text = eventsArray[indexPath.row]["strAwayTeam"] as? String
            resultsCell.homeTeamScore?.text =  eventsArray[indexPath.row]["intHomeScore"] as? String
            resultsCell.awayTeamScore?.text = eventsArray[indexPath.row]["intAwayScore"] as? String
            //check if api returns null data
            if ( eventsArray[indexPath.row]["dateEvent"] is  NSNull) || (eventsArray[indexPath.row]["strTime"] is NSNull)
            {
              resultsCell.dateAndTime?.text = "no date"
            }else
            {
                resultsCell.dateAndTime?.text = (eventsArray[indexPath.row]["dateEvent"]as? String)! + " AT " +  (eventsArray[indexPath.row]["strTime"] as? String)!
            }
            //set against image and change its color
            let myImage = UIImage(named: "against")!
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            resultsCell.againstImage.image = tintableImage
            resultsCell.againstImage.tintColor = UIColor.red
             //make labels fit the content
           resultsCell.homeTeamName.adjustsFontSizeToFitWidth = true
            resultsCell.awayTeamName.adjustsFontSizeToFitWidth = true
           resultsCell.dateAndTime.adjustsFontSizeToFitWidth = true
            //make corner radous and borderd to the collection view
            resultsCollectionView.layer.cornerRadius=25
            resultsCollectionView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
            resultsCollectionView.layer.borderWidth = 2

        return resultsCell

        }

          /*--------------------------teamse collection view-------------------*/
        if collectionView == teamsCollectionView
        {
            let teamsCell = teamsCollectionView.dequeueReusableCell(withReuseIdentifier: "teamsCell", for: indexPath) as! TeamsCollectionViewCell
            teamsCell .layer.cornerRadius=30

          //      print(teamsArray[indexPath.row][  "strTeamBadge"] as! String)
                let str=(teamsArray[indexPath.row][  "strTeamBadge"] as! String)
           teamsCell .teamBadge?.sd_setImage(with: URL(string:str), placeholderImage: UIImage(named: "loading"))
 
            //make teams badge circle
            teamsCell .teamBadge?.layer.borderWidth = 1
            teamsCell .teamBadge?.layer.borderColor = UIColor.black.cgColor
            teamsCell .teamBadge?.layer.cornerRadius = ((teamsCell.teamBadge?.frame.width)! / 2)
            teamsCell .teamBadge?.clipsToBounds = true
            
            //set corner
            teamsCollectionView.layer.cornerRadius=25
            
            return teamsCell
     }
    return eventsCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        //navigate to teams details view when pressed the image
        if collectionView == teamsCollectionView
        {
            let teamDetails=self.storyboard?.instantiateViewController(withIdentifier: "teamDetail") as! TeamsDetailsViewController
            //gice the team details view team id to get the api to it
            teamDetails.teamId = (teamsArray[indexPath.row]["idTeam"] as! String)
            //fix the tab bar in the next view
          self.definesPresentationContext = true
            //fix the navigation bar to the view
            let navDetailsViewController: UINavigationController = UINavigationController(rootViewController: teamDetails)
          navDetailsViewController.modalPresentationStyle = .overCurrentContext
            //remove the favorite button when display the teams details view
            self.navigationItem.rightBarButtonItem=nil
            //navigate to the team view details
            self.present(navDetailsViewController, animated: true, completion: nil)
        }
    }
}
