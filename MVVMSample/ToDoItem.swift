//
//  ToDoItem.swift
//  MVVMSample
//
//  Created by Bhavna on 5/18/17.
//  Copyright © 2017 Bhavna. All rights reserved.
//

import UIKit

class ToDoItem: NSObject {
    var itemName: String!
    var completed: Bool = false
    var creationDate: Date = Date()

    init(itemName: String) {
        self.itemName = itemName
    }
}

class ToDoItemViewModel: CellRepresentable {
    var item: ToDoItem
    var estimatedRowHeight: CGFloat = 60

    var itemNameValue: String? {
        return item.itemName
    }

    init(item: ToDoItem) {
        self.item = item
    }

    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemCell = (tableView.dequeueReusableCell(withIdentifier: ItemCell.identifier(),
                                                            for: indexPath) as? ItemCell)!
        cell.setup(viewModel: self, atRow: indexPath.row)
        cell.selectionStyle = .none
        if self.item.completed {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}
