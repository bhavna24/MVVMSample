//
//  MVVMSampleTests.swift
//  MVVMSampleTests
//
//  Created by Bhavna on 6/5/17.
//  Copyright © 2017 Bhavna. All rights reserved.
//

import XCTest

class MVVMSampleTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        /* Put teardown code here. This method is called after the invocation of each test method
         * in the class.
         */
        super.tearDown()
    }

    func testToDoItemModelWithMarkAttendance() {
        let attendanceItem = ToDoItem(itemName: "Mark Attendance")
        let attendanceItemViewModel = ToDoItemViewModel(item: attendanceItem)
        XCTAssertEqual(attendanceItemViewModel.itemNameValue, "Mark Attendance")
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
