//
//  LoginViewController.swift
//  AlamofireDemo
//
//  Created by Dheeraj Arora on 26/11/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var reachability: Reachability?
    override func viewDidLoad() {
        super.viewDidLoad()
          designView()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Login Account"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    func designView()  {
        viewEmail.layer.cornerRadius = 20
        viewEmail.clipsToBounds = true
        
        viewPassword.layer.cornerRadius = 20
        viewPassword.clipsToBounds = true
        
        btnLogin.layer.cornerRadius = 20
        btnLogin.clipsToBounds = true
    }
    @IBAction func btnSignUpAction(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @IBAction func btnLoginAction(_ sender: Any) {
        if txtEmail.text! != "" && txtPassword.text! != ""{
            //call api
            loginApiCalling()
        }else{
            self.showAlertMessage(title: "", message: "Please fill all the fields")
        }
     }
    
    func loginApiCalling()   {
        do {
            self.reachability = try Reachability.init()
        } catch  {
            print("Unable to start notifier")
        }
        if ((reachability!.connection) != .unavailable){
            self.startActivityIndicator(withMsg: "Please Wait...", onView: self.view)
            
            let param = ["name":self.txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject, "password":self.txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,"device_id":"123456".trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,"device":"iPhone".trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject]
            
            let login = userLogin
            let requestOfApi = Alamofire.request(login, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil)
            requestOfApi.responseJSON { (responce) -> Void in
                //print(responce.request!)
                //print(responce.result)
                //print(responce.response ?? "")
                
                switch responce.result{
                case .success(let payload):
                    self.stopActivityIndicator(spinner: self.view)
                    if let a = payload as? Dictionary<String, AnyObject>{
                       print(a)
                        let resultValue = a as NSDictionary
                        let code = resultValue["result"] as! String
                        let message = resultValue["message"] as! String
                        
                        if code == "1"
                        {
                            
                            if let data = resultValue["data"] as? [String:AnyObject]{
                                let userId = data["id"] as! Int
                                let token = resultValue["token"] as! String
                                UserDefaults.standard.set(userId, forKey: "userId")
                                UserDefaults.standard.set(token, forKey: "ApiToken")
                                
                                let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
                                let closeAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) in
                                    self.goToHomePage()
                                }
                                alert.addAction(closeAction)
                                self.present(alert, animated: true, completion: nil)
                                
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
    
    func goToHomePage()  {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(next, animated: true)
    }
}

