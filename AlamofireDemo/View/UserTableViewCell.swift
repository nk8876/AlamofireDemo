//
//  UserTableViewCell.swift
//  AlamofireDemo
//
//  Created by Dheeraj Arora on 23/11/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblComapnyName: UILabel!
    @IBOutlet weak var lblCompanyPhrase: UILabel!
    @IBOutlet weak var lblAddress: UILabel!


    var users: UserModel?{
        didSet{
            lblName.text = users?.name
            lblUserName.text = users?.username
            lblEmail.text = users?.email
            lblPhone.text = users?.phone
            lblComapnyName.text = users?.company?.companyName
            lblCompanyPhrase.text = users?.company?.catchPhrase
            lblAddress.text = users?.address?.street
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
