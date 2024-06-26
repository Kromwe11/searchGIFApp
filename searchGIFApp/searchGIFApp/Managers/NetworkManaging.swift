//
//  NetworkManaging.swift
//  searchGIFApp
//
//  Created by Висент Щепетков on 26.06.2024.
//

import Foundation

final class NetworkManager: NetworkManaging {
    
    // MARK: - Private Properties
    private let apiKey = "zOc3QnTWoIKNONYMla2joTb5Z0PK1vvm"
    
    // MARK: - Public Methods
    func searchGIFs(keyword: String, offset: Int = 0, completion: @escaping (Result<GIFResponse, Error>) -> Void) {
        guard let url = URL(string: "https://api.giphy.com/v1/gifs/search?api_key=\(apiKey)&q=\(keyword)&limit=20&offset=\(offset)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 204, userInfo: nil)))
                return
            }

            do {
                let gifResponse = try JSONDecoder().decode(GIFResponse.self, from: data)
                completion(.success(gifResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
