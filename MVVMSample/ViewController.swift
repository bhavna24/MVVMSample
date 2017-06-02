//
//  ViewController.swift
//  MVVMSample
//
//  Created by Bhavna on 5/18/17.
//  Copyright © 2017 Bhavna. All rights reserved.
//

import UIKit

enum ToDoItemState {
    case active
    case inactive
    case all
}

class ViewController: UIViewController {

    @IBOutlet weak var todoTableView: UITableView!
    var toDoItems = [ToDoItemViewModel]()
    var state: ToDoItemState = .all
    var dataArray = [ToDoItemViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        setupTableView()
        loadSampleData()
        viewAllItems(UIAlertAction())
        // Do any additional setup after loading the view, typically from a nib.
    }

    func setupNavigationItems() {
        self.navigationItem.title = "My to-do List"
        let addNewToDoBtn = UIBarButtonItem(barButtonSystemItem: .add,
                                            target: self,
                                            action: #selector(ViewController.addNewToDoBtnTapped(_:)))
        self.navigationItem.rightBarButtonItem = addNewToDoBtn

        let filterBtn = UIBarButtonItem(title: "Filter",
                                        style: .plain,
                                        target: self,
                                        action: #selector(ViewController.filterBtnTapped(_:)))
        self.navigationItem.leftBarButtonItem = filterBtn

    }

    func setupTableView() {
        todoTableView.delegate = self
        todoTableView.dataSource =  self
        todoTableView.bounces = false
        todoTableView.register(ItemCell.nib(), forCellReuseIdentifier: ItemCell.identifier())
    }

    func loadSampleData() {
        toDoItems.append(ToDoItemViewModel.init(item: ToDoItem.init(itemName: "Mark Attendance")))
    }

    func filterBtnTapped(_ lbbi: UIBarButtonItem) {

        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "View By Active State",
                                            style: .default,
                                            handler: viewActiveItems))
        actionSheet.addAction(UIAlertAction(title: "View By Inactive State",
                                            style: .default,
                                            handler: viewInactiveItems))
        actionSheet.addAction(UIAlertAction(title: "View All", style: .default, handler: viewAllItems))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.popoverPresentationController?.sourceView = self.view
        actionSheet.popoverPresentationController?.barButtonItem = lbbi
        present(actionSheet, animated: true, completion: nil)

    }

    // Display list of inactive toDo items
    fileprivate func viewInactiveItems(_ action: UIAlertAction) {
        self.state = .inactive
        self.dataArray = toDoItems.filter({return $0.item.completed == true })
        self.todoTableView.reloadData()
    }

    // Display list of active toDo items
    fileprivate func viewActiveItems(_ action: UIAlertAction) {
        self.state = .active
        self.dataArray = toDoItems.filter({return $0.item.completed == false })
        self.todoTableView.reloadData()
    }

    // Display list of all toDo items
    fileprivate func viewAllItems(_ action: UIAlertAction) {
        self.state = .all
        self.dataArray = self.toDoItems
        self.todoTableView.reloadData()
    }

    func addNewToDoBtnTapped(_ rbbi: UIBarButtonItem) {
        let addNewVC = self.storyboard!.instantiateViewController(withIdentifier: "AddNewToDoVC")
            as? AddNewToDoVC
        addNewVC?.delegate = self
        addNewVC?.mode = .add
        addNewVC?.toDoItemModel = ToDoItemViewModel(item: ToDoItem.init(itemName: ""))
        self.navigationController?.pushViewController(addNewVC!, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: AddToDoDelegate {

    func successDelegare(toDoItem: ToDoItemViewModel, mode: AddToDoMode) {
        if mode == .add {
            toDoItems.append(toDoItem)
        } else {
            for (index, itemObj) in toDoItems.enumerated() {
                if itemObj.item.creationDate == toDoItem.item.creationDate {
                    toDoItems[index] = toDoItem
                    break
                }
            }
        }
        self.state = .all
        self.dataArray = self.toDoItems
        self.todoTableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell: ItemCell = (self.dataArray[indexPath.row].cellInstance(
            tableView, indexPath: indexPath) as? ItemCell)!
        itemCell.delegate = self
        return itemCell

    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.dataArray[indexPath.row].estimatedRowHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todoTableView.deselectRow(at: indexPath, animated: false)
        let tappedItem: ToDoItemViewModel = self.dataArray[indexPath.row]
        tappedItem.item.completed = !tappedItem.item.completed
        todoTableView.reloadData()
    }
}

extension ViewController: ItemEditDelegate {
    func editItem(itemCell cell: ItemCell, atRow row: Int) {

        let addNewVC = self.storyboard!.instantiateViewController(withIdentifier: "AddNewToDoVC")
                        as? AddNewToDoVC
        addNewVC?.delegate = self
        addNewVC?.mode = .edit
        addNewVC?.toDoItemModel = ToDoItemViewModel.init(item: self.dataArray[row].item)
        self.navigationController?.pushViewController(addNewVC!, animated: true)
    }
}
