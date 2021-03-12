//
//  SportsViewController.swift
//  Sports
//
//  Created by MacOSSierra on 2/16/21.


import Foundation
import UIKit
extension SportsViewController
{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

     return CGSize(width: collectionView.frame.width / 2, height: 230)
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SportsCollectionViewCell
        cell.sportNameLabel?.text=sportsArray[indexPath.row]["strSport"]!
        cell.sportNameLabel?.sizeToFit()
             cell.sportNameLabel?.font = UIFont(name: "Didot", size: 20)
        cell.sportImage?.sd_setImage(with: URL(string: sportsArray[indexPath.row][  "strSportThumb"]!), placeholderImage: UIImage(named: "loading"))
        cell.layer.cornerRadius=10
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
         let leaguesView=self.storyboard?.instantiateViewController(withIdentifier: "leaguesView") as! LeaguesTableViewController
        leaguesView.sportName = sportsArray[indexPath.row]["strSport"]!
           self.navigationController?.pushViewController(leaguesView, animated: true)
    }


}
