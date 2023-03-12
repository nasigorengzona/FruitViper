//
//  Interactor.swift
//  FruitViper
//
//  Created by erlina ng on 12/03/23.
//

import Foundation

protocol AnyInteractor {
    var presenter : AnyPresenter? {get set}
    
    func getFruits()
}

class UserInteractor : AnyInteractor {
    var presenter: AnyPresenter?
    
    func getFruits() {
        print("Getting fruits")
        
        guard let url = URL(string: "https://www.fruitmap.org/api/trees") else {return}
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchData(with: .failure(FetchError.failed))
                return
            }
            do {
                let entities = try JSONDecoder().decode([Fruit].self, from: data)
                self?.presenter?.interactorDidFetchData(with: .success(entities))
            } catch {
                self?.presenter?.interactorDidFetchData(with: .failure(error))
            }
        }
        task.resume()
    }
}
