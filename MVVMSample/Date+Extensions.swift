//
//  Date+Extensions.swift
//  MVVMSample
//
//  Created by Bhavna on 5/18/17.
//  Copyright © 2017 Bhavna. All rights reserved.
//

import UIKit

extension Date {

    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return "\(formatter.string(from: self))"
    }
}
