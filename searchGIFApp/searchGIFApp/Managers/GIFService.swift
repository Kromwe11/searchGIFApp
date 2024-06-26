//
//  GIFService.swift
//  searchGIFApp
//
//  Created by Висент Щепетков on 26.06.2024.
//

import Foundation

final class GIFService {
    
    // MARK: - Public Methods
    func downloadGIF(urlString: String, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let temporaryDirectoryURL = FileManager.default.temporaryDirectory
                let localURL = temporaryDirectoryURL.appendingPathComponent("\(UUID().uuidString).gif")
                try data.write(to: localURL)
                DispatchQueue.main.async {
                    completion(.success(localURL))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
