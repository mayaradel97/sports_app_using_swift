//
//  extensionFavoriteView.swift
//  Sports
//
//  Created by MacOSSierra on 3/3/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import Foundation
import  UIKit
import Alamofire
import CoreData
extension FavoritesTableViewController:favProtocol
{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        /*---------------------------check network-------------------------*/
        let net = NetworkReachabilityManager()
        
        net?.listener = { status in
            if net?.isReachable ?? false {
                
                switch status {
                    
                case .reachable(.ethernetOrWiFi):
                    //if connected to network navigate to leagues details view
                    print("The network is reachable over the WiFi connection")
                    let leaguesDetails=self.storyboard?.instantiateViewController(withIdentifier: "leaguesDetails") as! LeaguesDetailsViewController
                    leaguesDetails.leagueId = (self.leaguesArray[indexPath.row].value(forKey: "id") as? String)!
                    leaguesDetails.leagueName = (self.leaguesArray[indexPath.row].value(forKey: "name") as? String)!
                    leaguesDetails.leagueImage = (self.leaguesArray[indexPath.row].value(forKey: "image") as? String)!
                    leaguesDetails.leagueVideo = (self.leaguesArray[indexPath.row].value(forKey: "video") as? String)!
                    leaguesDetails.isFavView=true
                    leaguesDetails.favDelegate=self
                    //get rowvalue to delete the cell if you press unfavorite button
                    self.rowValue=indexPath.row
                    //self.definesPresentationContext = true
                    let navDetailsViewController: UINavigationController = UINavigationController(rootViewController: leaguesDetails)
                    navDetailsViewController.modalPresentationStyle = .overCurrentContext
                    self.present(navDetailsViewController, animated: true, completion: nil)
                  //  leaguesDetails.modalPresentationStyle = .overCurrentContext
                    
                    
                case .reachable(.wwan):
                    print("The network is reachable over the WWAN connection")
                    
                case .notReachable:
                    print("The network is not reachable")
                    //alert when there is no network
                    let alert = UIAlertController(title: "No Internet Connection ",
                                                  message: "Make sure your device is connected to the internet", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                case .unknown :
                    print("It is unknown whether the network is reachable")
                    
                }
            }
            
            
        }
        net?.startListening()
    }
        /*-------------method to navigate to youtube view------------------------*/
    func navigateToYoutubeView()
    {
        let videoView=self.storyboard?.instantiateViewController(withIdentifier: "videoView") as! YoutubeViewController
        videoView.videoName=self.leagueVideo
        videoView.isFavView=true
        let navDetailsViewController: UINavigationController = UINavigationController(rootViewController: videoView)
        self.present(navDetailsViewController, animated: true, completion: nil)
      //  videoView.modalPresentationStyle = .overCurrentContext
    }
    
       /*---------------fetch data from core data------------------------*/
    func fetchLeagues()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext=appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject> (entityName: "Leagues")
        do
        {
            leaguesArray=try managedContext.fetch(fetchRequest)
        }
        catch let error
        {
            print(error)
        }
        tableView.reloadData()
   
    }
    //if you press unfavorite button delete the favorite leaguee
    func deleteFavorite()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext=appDelegate.persistentContainer.viewContext
        managedContext.delete(leaguesArray[ rowValue])
        leaguesArray.remove(at:  rowValue)
        
        do{
            try managedContext.save()
        }
        catch let error
        {
            print(error)
        }
        tableView.reloadData()
    }
    //change delete button background color
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            self.tableView.dataSource?.tableView!(self.tableView, commit: .delete, forRowAt: indexPath)
            return
        }
        deleteButton.backgroundColor = UIColor.black
        
        return [deleteButton]
    }

    //delete the favorite from array and core data when swipe the cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
       
       
        if editingStyle == .delete
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext=appDelegate.persistentContainer.viewContext
            managedContext.delete(leaguesArray[indexPath.row])
            leaguesArray.remove(at: indexPath.row)
            
            do{
                try managedContext.save()
            }
            catch let error
            {
                print(error)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }

}

