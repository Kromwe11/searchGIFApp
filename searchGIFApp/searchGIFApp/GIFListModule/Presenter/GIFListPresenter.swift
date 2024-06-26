//
//  GIFListPresenter.swift
//  searchGIFApp
//
//  Created by Висент Щепетков on 26.06.2024.
//

import Foundation

final class GIFListPresenter: GIFListPresenterProtocol {
    
    // MARK: - Public Properties
    weak var view: GIFListViewProtocol?
    var interactor: GIFListInteractorInputProtocol?
    var router: GIFListRouterProtocol?
    
    // MARK: - Private Properties
    private var gifs: [GIFData] = []
    private var currentPage = 0
    private var currentKeyword = ""
    
    // MARK: - Public Methods
    func searchGIFs(with keyword: String) {
        currentKeyword = keyword
        currentPage = 0
        gifs.removeAll()
        view?.showLoading()
        interactor?.searchGIFs(with: keyword, page: currentPage, isPagination: false)
    }
    
    func loadMoreGIFs() {
        currentPage += 1
        interactor?.searchGIFs(with: currentKeyword, page: currentPage, isPagination: true)
    }
    
    func didSelectGIF(_ gif: GIFData) {
        view?.dismissKeyboard()
        interactor?.downloadGIF(urlString: gif.images.fixed_width.url)
    }
}

// MARK: - GIFListInteractorOutputProtocol
extension GIFListPresenter: GIFListInteractorOutputProtocol {
    
    func didRetrieveGIFs(_ gifs: [GIFData], isPagination: Bool) {
        if isPagination {
            view?.appendGIFs(gifs)
        } else {
            view?.showGIFs(gifs)
        }
        view?.hideLoading()
    }

    func didFailToRetrieveGIFs(with error: Error) {
        view?.hideLoading()
        view?.showError(error.localizedDescription)
    }
    
    func didDownloadGIF(_ url: URL) {
        view?.shareGIF(url: url)
    }
}
