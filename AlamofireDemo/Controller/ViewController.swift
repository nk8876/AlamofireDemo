//
//  ViewController.swift
//  AlamofireDemo
//
//  Created by Dheeraj Arora on 23/11/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    var users : [UserModel] = []
    var myResponce: JSON = []
  
    @IBOutlet weak var myTableView: UserTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
       
    }

    func fetchUser() {
     
      self.startActivityIndicator(withMsg: "Please Wait..", onView: self.view)
       HelperMethod.instance.getUserFromUrl(strURL: fetch_Url) { (userJson) in
        self.stopActivityIndicator(spinner: self.view)
            if userJson != nil {
                    self.myResponce = userJson

                for i in 0..<self.myResponce.count{
                    let singlaUser = UserModel(userJson: self.myResponce[i])
                    self.users.append(singlaUser)
                }
                DispatchQueue.main.async {
                      self.myTableView.userDataSourceArray = self.users
                     
                }
              
            }
        }

    }
}

