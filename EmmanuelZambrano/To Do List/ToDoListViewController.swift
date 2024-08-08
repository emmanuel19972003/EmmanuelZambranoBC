//
//  ToDoList.swift
//  EmmanuelZambrano
//
//  Created by Emmanuel Zambrano on 7/08/24.
//

import UIKit

final class ToDoListViewController: UIViewController, ToDoListViewControllerProtocol {
    
    var presenter: ToDoListPresenterProtocol?
    
    var pcikerData: [ToDoListEntity] = []
    
    var timer: Timer?
    var timeRemaining = 300
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "To do list"
        view.textAlignment = .center
        view.textColor = .black
        view.font = UIFont.boldSystemFont(ofSize: 25.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var addButton: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "plus.circle")
        let tap = UITapGestureRecognizer(target: self, action: #selector(addButtonTapped))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var timeLeft: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.text = "5:43"
        view.font = UIFont.systemFont(ofSize: 25.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var taskPicker: UIPickerView = {
        let view = UIPickerView()
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var descriptionTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 25.0)
        view.text = "Description: "
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewComponents()
        ViewConstraints()
        presenter?.getTask()
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let currentItme = taskPicker.selectedRow(inComponent: 0)
        if !pcikerData.isEmpty {
            updateDescription(description: pcikerData[currentItme].description)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter?.requestNotificationPermission()
    }
    
    @objc func addButtonTapped() {
        let addTask = AddTaskViewController()
        addTask.delegate = self
        navigationController?.pushViewController(addTask, animated: true)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            updateTimerLabel(seconds: timeRemaining)
        } else {
            timer?.invalidate()
        }
    }
    func updatePicker(pickerInfo: [ToDoListEntity]) {
        pcikerData = pickerInfo
        taskPicker.reloadAllComponents()
    }
    
    func addItemToPicker(pickerInfo: ToDoListEntity) {
        pcikerData.append(pickerInfo)
        taskPicker.reloadAllComponents()
    }
    
    func updateDescription(description: String) {
        descriptionLabel.text = description
    }
    
    func storeTask() {
        presenter?.storeTask(tasks: pcikerData)
    }
    
    func updateTimerLabel(seconds: Int) {
        let time = presenter?.convertSecondsToMinutesAndSecondsString(seconds: seconds)
        timeLeft.text = time
    }
    
    private func viewComponents() {
        view.addSubview(titleLabel)
        view.addSubview(addButton)
        view.addSubview(timeLeft)
        view.addSubview(taskPicker)
        view.addSubview(descriptionTitleLabel)
        view.addSubview(descriptionLabel)
    }
    
    private func ViewConstraints() {
        titleLabelConstraints()
        addButtonConstraints()
        timeLeftConstraints()
        taskPickerConstraints()
        descriptionTitleLabelConstraints()
        descriptionLabelConstraints()
    }
    
    private func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func addButtonConstraints() {
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            addButton.heightAnchor.constraint(equalToConstant: 35),
            addButton.widthAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func timeLeftConstraints() {
        NSLayoutConstraint.activate([
            timeLeft.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            timeLeft.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
        ])
    }
    
    private func taskPickerConstraints() {
        NSLayoutConstraint.activate([
            taskPicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            taskPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            taskPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            taskPicker.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func descriptionTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionTitleLabel.topAnchor.constraint(equalTo: taskPicker.bottomAnchor, constant: 20),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func descriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

extension ToDoListViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pcikerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pcikerData[row].name
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if !pcikerData.isEmpty {
            let description = pcikerData[row].description
            updateDescription(description: description)
        }
    }
}

extension ToDoListViewController: AddTaskProtocol {
    func addNewTask(task: ToDoListEntity) {
        addItemToPicker(pickerInfo: task)
        storeTask()
    }
}
