//
//  YoutubeViewController.swift
//  Sports
//
//  Created by MacOSSierra on 2/18/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit
import WebKit
class YoutubeViewController: UIViewController , WKNavigationDelegate
{
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var videoName:String!=""//url video
    var isFavView:Bool=false
   
    override func viewDidLoad()
    {
   
        super.viewDidLoad()
        
        //set  webview delegate
        webView.navigationDelegate=self
   
        //indicator properties
        indicator.color = view.tintColor
        indicator.transform = CGAffineTransform(scaleX: 2, y: 2)
    //  print(videoName)
        //webview request
        if let str = videoName
        {

        webView.load(URLRequest(url: URL(string: "https://\(str)")!))
        }
        //check if it's navigate from favorite view put back button
        if(isFavView)
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
    }
    
    //back button action
    @objc func back()
    {
        
        self.dismiss(animated: true, completion: nil)
        
    }

   //when webview start loading
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
         indicator.startAnimating()
    }
    //when webview end loading
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    {
       
        //change webview content size
        let js = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust='150%'"//dual size
        webView.evaluateJavaScript(js, completionHandler: nil)
        //hide and stop indicator
          indicator.isHidden = true
         indicator.stopAnimating()
     
    }

    
}
