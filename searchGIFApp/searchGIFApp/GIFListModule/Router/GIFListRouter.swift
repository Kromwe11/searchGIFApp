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

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.configure(networkManager: NetworkManager())
        
        return view
    }

    func navigateToGIFDetail(from view: GIFListViewProtocol?, with gif: GIFData) {
        // Реализация навигации к деталям GIF будет здесь
    }
}
