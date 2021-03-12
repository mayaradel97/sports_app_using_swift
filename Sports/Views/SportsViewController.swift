//
//  ViewController.swift
//  Sports
//
//  Created by MacOSSierra on 2/16/21.


import UIKit
import Alamofire
import SDWebImage
class SportsViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout
{

//    @IBOutlet weak var colView: UICollectionView!
    var sportsArray = Array<Dictionary<String, String>>()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       //fetch all the sports from api
        Alamofire.request("https://www.thesportsdb.com/api/v1/json/1/all_sports.php").responseJSON(completionHandler: {
            respone in
            if  let json =   respone.result.value as? Dictionary<String,Array<Dictionary<String,String>>>
            {
                self.sportsArray=json["sports"]!

            }
            
   
            self.collectionView.reloadData()
            
        })
        
    }
    
   

}

