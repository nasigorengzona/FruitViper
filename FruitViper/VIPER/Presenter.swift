//
//  Presenter.swift
//  FruitViper
//
//  Created by erlina ng on 12/03/23.
//

import Foundation

enum FetchError : Error {
   case failed
}

protocol AnyPresenter {
    var router : AnyRouter? {get set}
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    func interactorDidFetchData(with result : Result<[Fruit], Error>)
}

class UserPresenter : AnyPresenter {
    var router: AnyRouter?
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getFruits()
        }
    }
    
    var view: AnyView?
    
    func interactorDidFetchData(with result: Result<[Fruit], Error>) {
        switch result {
        case .success(let fruits) :
            view?.update(with: fruits)
        case .failure :
            view?.update(with: "Something went wrong")
        }
    }
    
}
