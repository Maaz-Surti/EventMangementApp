//
//  EventsTableViewCell.swift
//  EventManagementApp
//
//  Created by Maaz on 12/11/21.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    @IBOutlet var eventName: UILabel!
    @IBOutlet var startDate: UILabel!
    @IBOutlet var city: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
