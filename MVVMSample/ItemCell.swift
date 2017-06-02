//
//  ItemCell.swift
//  MVVMSample
//
//  Created by Bhavna on 5/19/17.
//  Copyright © 2017 Bhavna. All rights reserved.
//

import UIKit

protocol ItemEditDelegate {
    func editItem(itemCell cell: ItemCell, atRow row: Int)
}

class ItemCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!

    var delegate: ItemEditDelegate!
    var row = 0

    class func nib() -> UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }

    class func identifier() -> String {
        return "\(self)"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(viewModel: ToDoItemViewModel, atRow row: Int) {
        self.itemNameLabel?.text = viewModel.item.itemName
        self.creationDateLabel?.text = viewModel.item.creationDate.toString()
        self.row = row
    }

    @IBAction func editBtnTapped(_ sender: Any) {
        delegate!.editItem(itemCell: self, atRow: row)
    }

}
