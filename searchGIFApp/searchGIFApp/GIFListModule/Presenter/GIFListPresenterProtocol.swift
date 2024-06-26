//
//  GIFListPresenterProtocol.swift
//  searchGIFApp
//
//  Created by Висент Щепетков on 26.06.2024.
//

import Foundation

/// Протокол для управления представлением GIF списка
protocol GIFListPresenterProtocol: AnyObject {
    /// Поиск GIF по ключевому слову
    /// - Parameter keyword: ключевое слово для поиска
    func searchGIFs(with keyword: String)
    
    /// Загрузка дополнительных GIF для пагинации
    func loadMoreGIFs()
    
    /// Обработка выбора GIF
    /// - Parameter gif: выбранный GIF
    func didSelectGIF(_ gif: GIFData)
}
