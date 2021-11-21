//
//  CounterViewCell.swift
//  UIKitSwiftUIMigration
//
//  Created by Michael Abadi Santoso on 19/11/2564 BE.
//

import UIKit

protocol CounterViewCellDelegate: AnyObject {
    func didTapUpdate(_ viewCell: UITableViewCell)
}

class CounterViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!

    weak var delegate: CounterViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func handleUpdate(_ sender: Any) {
        delegate?.didTapUpdate(self)
    }

}
