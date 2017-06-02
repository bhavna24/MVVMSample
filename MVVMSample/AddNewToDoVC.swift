//
//  AddNewToDoVC.swift
//  MVVMSample
//
//  Created by Bhavna on 5/18/17.
//  Copyright © 2017 Bhavna. All rights reserved.
//

import UIKit

protocol AddToDoDelegate {
    func successDelegare(toDoItem: ToDoItemViewModel, mode: AddToDoMode)
}

enum AddToDoMode {
    case add
    case edit
}

class AddNewToDoVC: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    var delegate: AddToDoDelegate!
    var mode: AddToDoMode!
    var toDoItemModel: ToDoItemViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationItems()
        self.setUpView()
        // Do any additional setup after loading the view.
    }

    func setUpView() {
        if toDoItemModel.item.itemName != nil &&
            toDoItemModel.item.itemName.characters.count > 0 {
            textField.text = toDoItemModel.item.itemName
        }
        if mode == .add {
            addBtn.setTitle("Add", for: .normal)
        } else {
            addBtn.setTitle("Update", for: .normal)
        }
    }

    func setupNavigationItems() {

        if mode == .add {
            self.navigationItem.title = "Add ToDo"
        } else {
            self.navigationItem.title = "Edit ToDo"
        }

        let image: UIImage = UIImage(named: "back_icon.png")!
        let buttonFrame: CGRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        let button: UIButton = UIButton.init(frame: buttonFrame)
        button.setImage(image, for: UIControlState())
        button.setImage(image, for: .selected)
        button.addTarget(self, action: #selector(AddNewToDoVC.backButtonPressed(_:)), for:.touchUpInside)
        let leftButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = leftButton
    }

    func backButtonPressed(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func addBtnTapped(_ sender: Any) {
        self.textField.resignFirstResponder()

        if textField.text != nil && (textField.text?.characters.count)! > 0 {
            toDoItemModel.item.itemName = textField.text
            delegate.successDelegare(toDoItem: toDoItemModel, mode: self.mode)
            _ = self.navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Please enter valid text",
                                          message: nil,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
