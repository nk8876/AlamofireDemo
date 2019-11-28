//
//  HomeViewController.swift
//  AlamofireDemo
//
//  Created by Dheeraj Arora on 26/11/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var myCollection: UICollectionView!
    var dataInfo: NSMutableArray = []
    var reachability: Reachability?
    override func viewDidLoad() {
        super.viewDidLoad()
        apiCalling()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Category"
        self.navigationItem.hidesBackButton = true
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        let dic = dataInfo[indexPath.row] as! NSDictionary
        
        if (dic["name"] as? String) != ""
        {
            cell.lblName.text = dic["name"] as? String
        }
        let image_url = dic["image_url"] as! String
        DispatchQueue.main.async {
            do
            {
                let imageData = try Data.init(contentsOf: URL.init(string:image_url)!)
                DispatchQueue.main.async {
                    let image: UIImage = UIImage(data: imageData)!
                     cell.myImage.image = image
                }
            }
            catch {
                // error
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/2 - 1
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dic = dataInfo[indexPath.row] as! NSDictionary
        let id = dic["id"] as! Int
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = mainStoryboard.instantiateViewController(withIdentifier: "ImageListViewController") as! ImageListViewController
        newViewController.getCategory = id
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func apiCalling()   {
        do {
            self.reachability = try Reachability.init()
        } catch  {
            print("Unable to start notifier")
        }
        if ((reachability!.connection) != .unavailable){
            self.startActivityIndicator(withMsg: "Please Wait...", onView: self.view)
            
           
            let login = apiCategory
            let requestOfApi = Alamofire.request(login, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            requestOfApi.responseJSON { (responce) -> Void in
                print(responce.request!)
                print(responce.result)
                print(responce.response ?? "")
                
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
                            
                             let data = resultValue["records"] as! NSArray
                             self.dataInfo = NSMutableArray(array: data)
                              self.myCollection.reloadData()
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
