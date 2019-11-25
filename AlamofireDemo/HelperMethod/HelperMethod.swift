//
//  APIManager.swift
//  AlamofireDemo
//
//  Created by Dheeraj Arora on 23/11/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class HelperMethod {
    
    static let instance: HelperMethod = HelperMethod()
    
    private init() {

    }
    func getUserFromUrl(strURL: String, success: @escaping (JSON) -> Void)  {
            Alamofire.request(fetch_Url).responseJSON { (responseObject) in
            switch responseObject.result{
            case .success(let data):
            let resoponce = JSON(data)
                success(resoponce)
            case .failure(let error):
                success(error as! JSON)
            }
        }
    }
}

//TODO:- GET Method
//class func requestGETURL(strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
//    Alamofire.request(strURL).responseJSON { (responseObject) -> Void in
//        print("Url:\(strURL)")
//
//        print("JSONResponse: \(responseObject)")
//        if responseObject.result.isSuccess {
//            let resJson = JSON(responseObject.result.value!)
//            success(resJson)
//        }
//        if responseObject.result.isFailure {
//            let error : Error = responseObject.result.error!
//            failure(error)
//        }
//    }
//}
//class Connectivity {
//    class var isConnectedToInternet: Bool {
//        return NetworkReachabilityManager()!.isReachable
//    }
//}
//class HelperMethod : NSObject {
//    static let sharedInstance : HelperMethod = HelperMethod()
//
//    //TODO:- POST Method
//    class func requestPOSTURL(_ strURL : String, params : [String : Any]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
//
//        if !Connectivity.isConnectedToInternet {
//            Utils.showOKAlert(withTitle: "", message: "No internet connection available!")
//            return
//        }
//        Alamofire.request(strURL, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON { responseObject in
//            print("Url:\(strURL) \n Parameters: \(params  ?? ["" : "" as AnyObject])")
//
//            if responseObject.result.isSuccess {
//                let resJson = JSON(responseObject.result.value!)
//                success(resJson)
//            }
//            if responseObject.result.isFailure {
//                let error : Error = responseObject.result.error!
//                print("error in ServiceManager url: \(strURL) , error \(error)")
//                failure(error)
//            }
//        }
//
//    }
//    //TODO:- GET Method
//    class func requestGETURL(strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
//        Alamofire.request(strURL).responseJSON { (responseObject) -> Void in
//            print("Url:\(strURL)")
//
//            print("JSONResponse: \(responseObject)")
//            if responseObject.result.isSuccess {
//                let resJson = JSON(responseObject.result.value!)
//                success(resJson)
//            }
//            if responseObject.result.isFailure {
//                let error : Error = responseObject.result.error!
//                failure(error)
//            }
//        }
//    }
//}
//
