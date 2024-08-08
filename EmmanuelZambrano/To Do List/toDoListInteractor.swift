//
//  toDoListInteractor.swift
//  EmmanuelZambrano
//
//  Created by Emmanuel Zambrano on 7/08/24.
//

import Foundation


class toDoListInteractor: toDoListInteractorProtocol {
    weak var presenter: ToDoListPresenterProtocol?
    let defaults = UserDefaults.standard
    
    func getTask() {
        if let savedData = defaults.data(forKey: "StoreTaks"),
           let decodedItems = try? JSONDecoder().decode([ToDoListEntity].self, from: savedData) {
            
            presenter?.updatePicker(pickerInfo: decodedItems)
        }
       
    }

    func storeTask(tasks: [ToDoListEntity]) {
        if let encoded = try? JSONEncoder().encode(tasks) {
            defaults.set(encoded, forKey: "StoreTaks")
        }
    }
}
