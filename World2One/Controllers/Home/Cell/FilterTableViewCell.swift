//
//  FilterTableViewCell.swift
//  World2one
//
//  Created by Moin on 04/02/2025.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
