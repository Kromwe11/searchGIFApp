//
//  GIFListViewController.swift
//  searchGIFApp
//
//  Created by Висент Щепетков on 26.06.2024.
//

import UIKit

final class GIFListViewController: UIViewController {
    
    // MARK: - Private Properties
    private var presenter: GIFListPresenterProtocol?
    private var gifService: GIFServiceProtocol?
    private var gifs: [GIFData] = []
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let searchBar = UISearchBar()
    private var searchTimer: Timer?
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    private enum Constants {
        static let searchTimerInterval: TimeInterval = 1.0
        static let gifCellIdentifier = "GIFCell"
        static let errorTitle = "Error"
        static let okActionTitle = "OK"
        static let cellSpacing: CGFloat = 10
        static let itemSize: CGFloat = UIScreen.main.bounds.width / 2 - 10
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundColor()
        setupSearchBar()
        setupCollectionView()
        setupLoadingIndicator()
        setupTapGesture()
    }
    
    // MARK: - Configuration
    func configure(presenter: GIFListPresenterProtocol, gifService: GIFServiceProtocol) {
        self.presenter = presenter
        self.gifService = gifService
    }
    
    // MARK: - Private Methods
    private func setupBackgroundColor() {
        view.backgroundColor = .white
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Constants.itemSize, height: Constants.itemSize)
        layout.minimumLineSpacing = Constants.cellSpacing
        layout.minimumInteritemSpacing = Constants.cellSpacing
        collectionView.setCollectionViewLayout(layout, animated: false)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GIFCollectionViewCell.self, forCellWithReuseIdentifier: Constants.gifCellIdentifier)
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupLoadingIndicator() {
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
}

// MARK: - GIFListPresenterOutput
extension GIFListViewController: GIFListPresenterOutput {
    func showGIFs(_ gifs: [GIFData]) {
        DispatchQueue.main.async {
            self.gifs = gifs
            self.collectionView.reloadData()
            self.hideLoading()
        }
    }
    
    func appendGIFs(_ gifs: [GIFData]) {
        DispatchQueue.main.async {
            let startIndex = self.gifs.count
            let endIndex = startIndex + gifs.count
            let indexPaths = (startIndex..<endIndex).map { IndexPath(item: $0, section: 0) }
            self.gifs.append(contentsOf: gifs)
            self.collectionView.insertItems(at: indexPaths)
        }
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            self.hideLoading()
            let alert = UIAlertController(title: Constants.errorTitle, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constants.okActionTitle, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.loadingIndicator.startAnimating()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
        }
    }
    
    func shareGIF(url: URL) {
        searchBar.resignFirstResponder()
        dismissKeyboard()
        
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UICollectionViewDataSource
extension GIFListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.gifCellIdentifier, for: indexPath) as? GIFCollectionViewCell else {
            return UICollectionViewCell()
        }
        let gif = gifs[indexPath.item]
        if let gifService = gifService {
            cell.configure(with: gif, gifService: gifService)
        } else {
            cell.configure(with: gif, gifService: nil)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension GIFListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gif = gifs[indexPath.item]
        presenter?.didSelectGIF(gif)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            presenter?.loadMoreGIFs()
        }
    }
}

// MARK: - UISearchBarDelegate
extension GIFListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: Constants.searchTimerInterval, repeats: false) { [weak self] _ in
            self?.presenter?.searchGIFs(with: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
