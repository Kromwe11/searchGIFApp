//
//  GIFListRouterProtocol.swift
//  searchGIFApp
//
//  Created by Висент Щепетков on 26.06.2024.
//

import UIKit

/// Протокол для маршрутизации в модуле GIF списка
protocol GIFListRouterProtocol: AnyObject {
    /// Создает модуль списка GIF
    /// - Returns: UIViewController для списка GIF
    static func createGIFListModule() -> UIViewController
    
    /// Навигация к деталям GIF
    /// - Parameters:
    ///   - view: текущее представление
    ///   - gif: данные о GIF
    func navigateToGIFDetail(from view: GIFListViewProtocol?, with gif: GIFData)
}
