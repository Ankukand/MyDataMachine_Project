//
//  CustomTableViewCell.swift
//  MyDataMachine_Project
//
//  Created by Anku on 27/04/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var lblData: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
