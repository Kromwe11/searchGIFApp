//
//  GIFListRouter.swift
//  searchGIFApp
//
//  Created by Висент Щепетков on 26.06.2024.
//

import UIKit

final class GIFListRouter: GIFListRouterProtocol {
    
    // MARK: - Public Methods
    static func createGIFListModule() -> UIViewController {
        let view = GIFListViewController()
        let interactor = GIFListInteractor()
        let presenter = GIFListPresenter()
        let router = GIFListRouter()
        let gifService = GIFService()

        view.configure(presenter: presenter, gifService: gifService)
        presenter.configure(view: view, interactor: interactor, router: router)
        interactor.configure(networkManager: NetworkManager(), presenter: presenter)
        
        return view
    }

    func navigateToGIFDetail(from view: GIFListPresenterOutput?, with gif: GIFData) {
        // Реализация навигации к деталям GIF будет здесь
    }
}
