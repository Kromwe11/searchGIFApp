//
//  GIFListInteractor.swift
//  searchGIFApp
//
//  Created by Висент Щепетков on 26.06.2024.
//

import Foundation

final class GIFListInteractor: GIFListInteractorInputProtocol {
        
    // MARK: - Private Properties
    private var networkManager: NetworkManaging?
    private var gifService = GIFService()
    private weak var presenter: GIFListInteractorOutputProtocol?
    
    // MARK: - Public Methods
    func configure(networkManager: NetworkManaging, presenter: GIFListInteractorOutputProtocol) {
        self.networkManager = networkManager
        self.presenter = presenter
    }
    
    func searchGIFs(with keyword: String, page: Int, isPagination: Bool) {
        let offset = page * 20
        networkManager?.searchGIFs(keyword: keyword, offset: offset) { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter?.didRetrieveGIFs(response.data, isPagination: isPagination)
            case .failure(let error):
                self?.presenter?.didFailToRetrieveGIFs(with: error)
            }
        }
    }
    
    func downloadGIF(urlString: String) {
        gifService.downloadGIF(urlString: urlString) { [weak self] result in
            switch result {
            case .success(let localURL):
                self?.presenter?.didDownloadGIF(localURL)
            case .failure(let error):
                self?.presenter?.didFailToRetrieveGIFs(with: error)
            }
        }
    }
}
