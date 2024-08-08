//
//  ToDoListProtocols.swift
//  EmmanuelZambrano
//
//  Created by Emmanuel Zambrano on 7/08/24.
//

import Foundation
import UIKit

protocol ToDoListViewControllerProtocol {
    var presenter: ToDoListPresenterProtocol? {get set}
    func updatePicker(pickerInfo: [ToDoListEntity])
}

protocol ToDoListPresenterProtocol {
    var view: ToDoListViewControllerProtocol? {get set}
    var interactor: toDoListInteractorProtocol? {get set}
    var router: toDoListRouterProtocol? {get set}
    func updatePicker(pickerInfo: [ToDoListEntity])
    func getTask()
    func storeTask(tasks: [ToDoListEntity])
    func requestNotificationPermission()
    func sendNotification(title: String, body: String)
    func convertSecondsToMinutesAndSecondsString(seconds: Int) -> String
}

protocol toDoListInteractorProtocol {
    var presenter: ToDoListPresenterProtocol? {get set}
    func getTask()
    func storeTask(tasks: [ToDoListEntity])
}

protocol toDoListRouterProtocol {
    static func createModule() -> UIViewController
}
