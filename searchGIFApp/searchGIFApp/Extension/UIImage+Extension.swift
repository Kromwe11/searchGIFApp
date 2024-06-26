//
//  Extension.swift
//  searchGIFApp
//
//  Created by Висент Щепетков on 26.06.2024.
//

import SwiftGifOrigin

extension UIImageView {
    func loadGif(url: URL, completion: @escaping () -> Void) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                let gifImage = UIImage.gif(data: data)
                DispatchQueue.main.async {
                    self.image = gifImage
                    completion()
                }
            } else {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
}
