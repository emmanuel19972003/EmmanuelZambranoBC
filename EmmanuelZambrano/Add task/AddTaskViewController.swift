//
//  AddTask.swift
//  EmmanuelZambrano
//
//  Created by Emmanuel Zambrano on 8/08/24.
//

import UIKit

protocol AddTaskProtocol {
    func addNewTask(task: ToDoListEntity)
}

class AddTaskViewController: UIViewController {
    
    var delegate: AddTaskProtocol?
    //MARK: view components
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 35
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var taskNameLabel: UILabel = {
        let view = UILabel()
        view.text = "task Name"
        view.textAlignment = .center
        view.textColor = .black
        view.font = UIFont.boldSystemFont(ofSize: 25.0)
        view.heightAnchor.constraint(equalToConstant: 33).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var taskNameTextField: UITextField = {
        let view = UITextField()
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1.0
        view.placeholder = " Name"
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.heightAnchor.constraint(equalToConstant: 33).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.text = "Task Description"
        view.textAlignment = .center
        view.textColor = .black
        view.font = UIFont.boldSystemFont(ofSize: 25.0)
        view.heightAnchor.constraint(equalToConstant: 33).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var taskDescriptionTextField: UITextField = {
        let view = UITextField()
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1.0
        view.placeholder = " Description"
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.heightAnchor.constraint(equalToConstant: 33).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var saveButton: UIButton = {
        let view = UIButton()
        view.addTarget(self, action:#selector(self.saveTask), for: .touchUpInside)
        view.setTitle("Save", for: .normal)
        view.backgroundColor = .systemBlue
        view.titleLabel?.textColor = .white
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //MARK: live cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        fillStackView()
        stackViewConstraint()
        view.backgroundColor = .white
    }
    //MARK: update UI funcs
    @objc
    func saveTask() {
        guard let name = taskNameTextField.text,
              let description = taskDescriptionTextField.text else {
            return
        }
        if !checkValidFiles(name: name, description: description) {
            return
        }
        
        let task = ToDoListEntity(name: name, description: description)
        delegate?.addNewTask(task: task)
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    func checkValidFiles(name: String, description: String) -> Bool {
        if name.isEmpty {
            showAlert(title: "Title can't be empty", message: "Add a title to save the task")
            return false
        }
        if  description.isEmpty {
            showAlert(title: "Description can't be empty", message: "Add a Description to save the task")
            return false
        }
        return true
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: view Constraints
    private func fillStackView() {
        stackView.addArrangedSubview(taskNameLabel)
        stackView.addArrangedSubview(taskNameTextField)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(taskDescriptionTextField)
        stackView.addArrangedSubview(saveButton)
        stackView.addArrangedSubview(UIView())
    }
    
    func stackViewConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
    }
}

#Preview {
    AddTaskViewController()
}
