//
//  TableViewCell.swift
//  UseCoreData
//
//  Created by Shake Yeritsyan on 5/23/20.
//  Copyright © 2020 Sose Yeritsyan. All rights reserved.
//

import UIKit
import CoreData

class UserCell: UITableViewCell {

    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ parameter: User) {
        
        firstNameLbl.text = parameter.fname
        lastNameLbl.text = parameter.lname
        emailLbl.text = parameter.email
    }
    
    func getEmail() -> String? {
        return self.emailLbl.text
    }
    
}
