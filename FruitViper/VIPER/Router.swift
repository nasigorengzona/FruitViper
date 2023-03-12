//
//  Router.swift
//  FruitViper
//
//  Created by erlina ng on 12/03/23.
//

import Foundation
import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry : EntryPoint? {get}
    static func start() -> AnyRouter
}

class UserRouter : AnyRouter {
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = UserRouter()
        
        //Assign V I P
        var view : AnyView = UserViewController()
        var interactor : AnyInteractor = UserInteractor()
        var presenter : AnyPresenter = UserPresenter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        //Assign router as the entry point
        router.entry = view as? EntryPoint
        
        return router
    }
}
