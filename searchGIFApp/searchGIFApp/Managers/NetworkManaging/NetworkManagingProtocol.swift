//
//  NetworkManagingProtocol.swift
//  searchGIFApp
//
//  Created by Висент Щепетков on 26.06.2024.
//

import Foundation

/// Протокол для управления сетевыми запросами
protocol NetworkManaging {
    /// Поиск GIF по ключевому слову
    /// - Parameters:
    ///   - keyword: ключевое слово для поиска
    ///   - offset: смещение для пагинации
    ///   - completion: завершение с результатом запроса
    func searchGIFs(keyword: String, offset: Int, completion: @escaping (Result<GIFResponse, Error>) -> Void)
}
