//
//  extensionCoreDataLeaguesDetails.swift
//  Sports
//
//  Created by MacOSSierra on 3/3/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import Foundation
import CoreData
import UIKit
extension LeaguesDetailsViewController
{
     /*--------------------------insert in core data ------------------------*/
    func insertFavData()
    {
        //check first if the league already exists in the core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext=appDelegate.persistentContainer.viewContext
        let request : NSFetchRequest = NSFetchRequest<NSManagedObject> (entityName: "Leagues");
        request.predicate = NSPredicate(format: "id==%@", leagueId)
        do
        {
            let results = try managedContext.count(for: request)
            //if it is already exit not added it to core data
             if results>0
             {
                  print("exists")
            }
                //if not exists insert the data
           else
             {
           // print("not")
           self.insertIfExists()
           }
            }
        
        catch let error
        {
            print(error)
        }
      
    }

//insert in core data
func insertIfExists()
{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext=appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Leagues", in: managedContext)
    let league = NSManagedObject(entity: entity!, insertInto: managedContext)
    league.setValue(leagueName, forKey: "name")
    league.setValue(leagueImage, forKey: "image")
    league.setValue(leagueId, forKey: "id")
    league.setValue(leagueVideo, forKey: "video")
   // print("core\(leagueVideo)")
    do
    {
        try managedContext.save()
    }
    catch let error
    {
        print(error)
    }
}
}
