//
//  ViewController.swift
//  Sports
//
//  Created by MacOSSierra on 2/18/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit

class ViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
           /*------------------------font of tab bar item------------*/
       UITabBarItem.appearance().setTitleTextAttributes( [NSAttributedString.Key.font: UIFont(name: "Noteworthy", size: 25)!], for: .normal)
       UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Noteworthy", size: 25)!], for: .selected)
     
        
      /*------------------------font of back button-------------*/
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Didot", size: 30.0)!], for: .normal)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
