//
//  GIFServiceProtocol.swift
//  searchGIFApp
//
//  Created by Висент Щепетков on 26.06.2024.
//

import SwiftGifOrigin

/// Протокол, определяющий методы для загрузки и скачивания GIF изображений.
protocol GIFServiceProtocol {
    
    /// Загружает GIF изображение по указанному URL.
    ///
    /// - Parameters:
    ///   - url: URL GIF изображения, которое нужно загрузить.
    ///   - completion: Замыкание, вызываемое после завершения загрузки.
    ///   В случае успеха передает UIImage с загруженным GIF изображением, иначе nil.
    func loadGif(url: URL, completion: @escaping (UIImage?) -> Void)
    
    /// Скачивает GIF изображение по указанному URL и сохраняет его в локальное хранилище.
    ///
    /// - Parameters:
    ///   - urlString: Строка с URL GIF изображения, которое нужно скачать.
    ///   - completion: Замыкание, вызываемое после завершения скачивания.
    ///   В случае успеха передает URL локального файла с загруженным GIF изображением, иначе ошибку.
    func downloadGIF(urlString: String, completion: @escaping (Result<URL, Error>) -> Void)
}
