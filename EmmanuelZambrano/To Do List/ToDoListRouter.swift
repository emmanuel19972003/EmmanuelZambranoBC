//
//  ToDoListRouter.swift
//  EmmanuelZambrano
//
//  Created by Emmanuel Zambrano on 7/08/24.
//

import UIKit

class toDoListRouter: toDoListRouterProtocol {
    
    static func createModule() -> UIViewController {
        let view = ToDoListViewController()
        let presenter = ToDoListPresenter()
        let interactor = toDoListInteractor()
        let router = toDoListRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return view

    }
}
