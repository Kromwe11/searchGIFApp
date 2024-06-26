//
//  GIFListViewProtocol.swift
//  searchGIFApp
//
//  Created by Висент Щепетков on 26.06.2024.
//

import Foundation

/// Протокол для отображения списка GIF
protocol GIFListViewProtocol: AnyObject {
    /// Отображает список GIF
    /// - Parameter gifs: массив GIF для отображения
    func showGIFs(_ gifs: [GIFData])
    
    /// Отображает ошибку
    /// - Parameter message: сообщение об ошибке
    func showError(_ message: String)
    
    /// Показывает индикатор загрузки
    func showLoading()
    
    /// Скрывает индикатор загрузки
    func hideLoading()
    
    /// Добавляет GIF к текущему списку
    /// - Parameter gifs: массив GIF для добавления
    func appendGIFs(_ gifs: [GIFData])
    
    /// Делится GIF по URL
    /// - Parameter url: URL GIF для шаринга
    func shareGIF(url: URL)
    
    /// Скрывает клавиатуру
    func dismissKeyboard()
}
