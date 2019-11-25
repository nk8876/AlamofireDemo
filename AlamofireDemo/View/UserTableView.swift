//
//  UserTableView.swift
//  AlamofireDemo
//
//  Created by Dheeraj Arora on 25/11/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import UIKit

class UserTableView: UITableView, UITableViewDataSource, UITableViewDelegate {

    var userDataSourceArray = [UserModel]() {
        didSet{
            reloadData()
        }
    }
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dataSource = self
        self.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userDataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        //        let obj = self.users[indexPath.row]
        //        cell.lblName.text = obj.name
        //        cell.lblUserName.text = obj.username
        //        cell.lblEmail.text = obj.email
        //        cell.lblPhone.text = obj.phone
        //        cell.lblAddress.text = obj.address?.street
        //        cell.lblComapnyName.text = obj.company?.companyName
        //        cell.lblCompanyPhrase.text = obj.company?.catchPhrase
        cell.users = self.userDataSourceArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
