//
//  ToDoListPresenter.swift
//  EmmanuelZambrano
//
//  Created by Emmanuel Zambrano on 7/08/24.
//

import Foundation
import UserNotifications

final class ToDoListPresenter: ToDoListPresenterProtocol {
    weak var view: ToDoListViewControllerProtocol?
    
    var interactor: toDoListInteractorProtocol?
    
    var router: toDoListRouterProtocol?
    
    func updatePicker(pickerInfo: [ToDoListEntity]) {
        view?.updatePicker(pickerInfo: pickerInfo)
    }
    
    func getTask() {
        interactor?.getTask()
    }
    
    func storeTask(tasks: [ToDoListEntity]) {
        interactor?.storeTask(tasks: tasks)
    }
    
    func convertSecondsToMinutesAndSecondsString(seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
    
    func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Permiso concedido")
            } else {
                print("Permiso denegado")
            }
        }
    }
    
    func sendNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: "fiveMinuteTimer", content: content, trigger: trigger)

        let center = UNUserNotificationCenter.current()
        center.add(request) { error in
            if let error = error {
                print("Error al programar la notificación: \(error.localizedDescription)")
            }
        }
    }
}
