//
//  CellRepresentable.swift
//  MVVMSample
//
//  Created by Bhavna on 5/18/17.
//  Copyright © 2017 Bhavna. All rights reserved.
//

import UIKit

protocol CellRepresentable {
    var estimatedRowHeight: CGFloat { get }
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}
