//
//  GIFCollectionViewCell.swift
//  searchGIFApp
//
//  Created by Висент Щепетков on 26.06.2024.
//

import UIKit
import SwiftGifOrigin

final class GIFCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    private let imageView = UIImageView()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    private enum Constants {
        static let placeholderImageName = "placeholder"
    }
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        loadingIndicator.stopAnimating()
    }
    
    // MARK: - Public Methods
    func configure(with gif: GIFData) {
        setupUIIfNeeded()

        imageView.image = nil
        loadingIndicator.startAnimating()

        let urlString = gif.images.fixed_width.url
        if let url = URL(string: urlString) {
            imageView.loadGif(url: url) { [weak self] in
                self?.loadingIndicator.stopAnimating()
            }
        } else {
            imageView.image = UIImage(named: Constants.placeholderImageName)
            loadingIndicator.stopAnimating()
        }
    }
    
    // MARK: - Private Methods
    private func setupUIIfNeeded() {
        guard contentView.subviews.isEmpty else { return }

        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)

        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loadingIndicator)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            loadingIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
