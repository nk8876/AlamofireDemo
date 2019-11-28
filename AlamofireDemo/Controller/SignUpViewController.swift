//
//  SignUpViewController.swift
//  AlamofireDemo
//
//  Created by Dheeraj Arora on 25/11/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var viewUsername: UIView!
    @IBOutlet weak var viewPhone: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var btnCreateAccount: UIButton!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var reachability: Reachability?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designView()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Create Account"
        self.navigationController!.navigationBar.tintColor = UIColor.white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes


    }
    func designView() {
        viewEmail.layer.cornerRadius = 20
        viewEmail.clipsToBounds = true
        
        viewPassword.layer.cornerRadius = 20
        viewPassword.clipsToBounds = true
        
        viewUsername.layer.cornerRadius = 20
        viewUsername.clipsToBounds = true
        
        viewPhone.layer.cornerRadius = 20
        viewPhone.clipsToBounds = true
        
        btnCreateAccount.layer.cornerRadius = 20
        btnCreateAccount.clipsToBounds = true
    }
    @IBAction func btnSignUpAction(_ sender: Any) {
        if txtUsername.text != "" && txtEmail.text != "" && txtPhone.text != "" && txtPassword.text != ""{
            //call api
            apiCalling()
        }else{
            let alert = UIAlertController(title: "", message: "Please fill all the fields", preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel) { (action) in
                print("Close")
            }
            alert.addAction(closeAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func apiCalling() {
        do {
            self.reachability = try Reachability.init()
        } catch  {
            print("Unable to start notifier")
        }
        if ((reachability!.connection) != .unavailable){
            
            self.startActivityIndicator(withMsg: "Please Wait...", onView: self.view)
            
            let param = ["name":self.txtUsername.text?.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject, "email":self.txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject, "mobile_no":self.txtPhone.text?.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject, "password":self.txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,"device_id":"123456".trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,"device":"iPhone".trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject]
            
            let url = signup
            let requestOfApi = Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil)
            requestOfApi.responseJSON { (responce) -> Void in
                //print(responce.request!)
                //print(responce.result)
                //print(responce.response ?? "")
                
                switch responce.result{
                case .success(let payload):
                    self.stopActivityIndicator(spinner: self.view)
                    if let a = payload as? Dictionary<String, AnyObject>{
                        //print(a)
                        let resultValue = a as NSDictionary
                        let code = resultValue["result"] as! String
                        let message = resultValue["message"] as! String
                        let token = resultValue["token"] as! String
                        if code == "1"
                        {
                            
                            if let data = resultValue["data"] as? [String:AnyObject]{
                                let userId = data["id"] as! Int
                                
                                UserDefaults.standard.set(userId, forKey: "userId")
                                UserDefaults.standard.set(token, forKey: "ApiToken")
                                
                                self.showAlertMessage(title: "", message: "Account Created Successfully")
                            }else{
                                self.showAlertMessage(title: "", message: "\(message)")
                            }
                            
                        }else{
                            self.showAlertMessage(title: "", message: "\(message)")
                        }
                    }
                case .failure(let error):
                    self.showAlertMessage(title: "", message: "\(error.localizedDescription)")
                }
            }
            
        }else{
            self.showAlertMessage(title: "", message: "Please check your internet connection")
        }
    }
    
}
