//
//  ImageListViewController.swift
//  AlamofireDemo
//
//  Created by Dheeraj Arora on 27/11/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import UIKit
import Alamofire

class ImageListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout  {
   
    @IBOutlet weak var myImageCollection: UICollectionView!
    var reachability: Reachability?
    var getCategory: Int = Int()
    var dataInfo: NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Image List"
        self.navigationController!.navigationBar.tintColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        apiCalling()
    }
    
    func apiCalling()   {
        do {
            self.reachability = try Reachability.init()
        } catch  {
            print("Unable to start notifier")
        }
        if ((reachability!.connection) != .unavailable){
            self.startActivityIndicator(withMsg: "Please Wait...", onView: self.view)
            
            
            let imageList = apiCategoryImageList
            let param = ["category_id": "\(getCategory)".trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject] as Dictionary<String, AnyObject>
            let requestOfApi = Alamofire.request(imageList, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
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
                            
                            let records = resultValue["records"] as! NSDictionary
                            let data = records["data"] as! NSArray
                            self.dataInfo = NSMutableArray(array: data)
                            self.myImageCollection.reloadData()
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageListCollectionViewCell", for: indexPath) as! ImageListCollectionViewCell
        
        cell.viewBackground.layer.borderWidth = 1
        cell.viewBackground.layer.borderColor = UIColor.gray.cgColor
        cell.viewBackground.layer.cornerRadius = 10
        cell.viewBackground.clipsToBounds = true
        
        let dic = dataInfo[indexPath.row] as! NSDictionary
        if let imagePath = dic["image_url"] as? String {
        DispatchQueue.main.async {
            do
            {
                let imageData = try Data.init(contentsOf: URL.init(string:imagePath)!)
                DispatchQueue.main.async {
                    let image: UIImage = UIImage(data: imageData)!
                    cell.imaImage.image = image
                }
            }
            catch {
                // error
            }
        }
    }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/2 - 1
        return CGSize(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
}
