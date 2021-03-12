//
//  extensionFavoriteButtonHandling.swift
//  Sports
//
//  Created by MacOSSierra on 3/7/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import Foundation
import UIKit
extension LeaguesDetailsViewController
{
    /*--if league details view disappear handling what will happen to fav button*/
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        //if you still favorite your league don't do anything
        if isfav==false && favImage=="fav"  && isFavView
        {
            print("donefetch")
        }
        //if you unfavorite the league when you open it from fav view
        if isfav==true && favImage=="favoriteFill" && isFavView
        {
            //delete this from fav view and core data
            favDelegate.deleteFavorite()
            
            print("deleted")
        }
        
        //if you favorite the league insert the data in coredata when you open it from main view
        if isfav==false && favImage=="fav"  && !isFavView
        {
            self.insertFavData()
        }
        //if you click multiple time fav and unfav and you unfav at the end so don't add this to core data
        if isfav==true && favImage=="favoriteFill" && !isFavView{
            print("return")
        }
        
    }
    
    /*---------fav button action------*/
    @objc func favClick(sender: UIBarButtonItem)
    {
        
        if isFavView && favImage=="fav" && isfav==false
        {
            favImage="fav"
            isfav=false
        }
        
        
        if favImage == "favoriteFill"
            
        {
            //set fav button
            favButton  = UIBarButtonItem(
                image: UIImage(named: favImage)?.withRenderingMode(.alwaysTemplate),
                style: .done, target: self, action: #selector(favClick(sender:)))
           //at the end set unfav button to set the other button when you click again
            favImage="fav"
            isfav=false
            
        }
        else
        {
            
            favButton = UIBarButtonItem(image: UIImage(named: favImage)?.withRenderingMode(.alwaysTemplate),
                                        style: .done, target: self, action: #selector(favClick(sender:)))
            favImage="favoriteFill"
            isfav=true
        }
        //add fav button to the navigation bar
        navigationItem.setRightBarButton(favButton , animated: true)
        
    }
    
    
}
