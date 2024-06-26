//
//  GIFListInteractorProtocol.swift
//  searchGIFApp
//
//  Created by Висент Щепетков on 26.06.2024.
//

import Foundation

/// Протокол для передачи данных из интерактора в презентер
protocol GIFListInteractorOutputProtocol: AnyObject {
    /// Сообщает о получении GIF
    /// - Parameter gifs: массив полученных GIF
    /// - Parameter isPagination: флаг пагинации
    func didRetrieveGIFs(_ gifs: [GIFData], isPagination: Bool)
    
    /// Сообщает о неудачной попытке получения GIF
    /// - Parameter error: ошибка получения
    func didFailToRetrieveGIFs(with error: Error)
    
    /// Сообщает о загрузке GIF
    /// - Parameter url: локальный URL загруженного GIF
    func didDownloadGIF(_ url: URL)
}

/// Протокол для передачи запросов от презентера к интерактору
protocol GIFListInteractorInputProtocol: AnyObject {
    /// Поиск GIF по ключевому слову
    /// - Parameters:
    ///   - keyword: ключевое слово для поиска
    ///   - page: номер страницы для пагинации
    ///   - isPagination: флаг пагинации
    func searchGIFs(with keyword: String, page: Int, isPagination: Bool)
    
    /// Загрузка GIF по URL
    /// - Parameter urlString: строка URL GIF
    func downloadGIF(urlString: String)
}
