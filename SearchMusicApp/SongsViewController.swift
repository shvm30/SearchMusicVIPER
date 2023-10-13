//
//  ViewController.swift
//  WheatherApp
//
//  Created by Владимир on 12.10.2023.
//

import UIKit

class SongsViewController: UIViewController {
    
    //MARK: Public proparties
    
    var songsPresenter: SongsPresenter?
    
    //MARK: - UI elements
    
    private lazy var songsTableView: UITableView = {
        let tabelView = UITableView()
        tabelView.register(SongTableViewCell.self, forCellReuseIdentifier: String(describing: SongTableViewCell.self))
        tabelView.delegate = self
        tabelView.dataSource = self
        tabelView.isHidden = true
        tabelView.translatesAutoresizingMaskIntoConstraints = false
        return tabelView
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.hidesWhenStopped = true
        aiv.isHidden = true
        aiv.translatesAutoresizingMaskIntoConstraints = false
        return aiv
    }()
    private let songsSearchBar = UISearchBar()
    
    //MARK: - Lify cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        songsSearchBar.delegate = self
        setViews()
        setConstraints()
    }
    
    //MARK: - Private methods
    
    private func setViews() {
        navigationItem.titleView = songsSearchBar
        view.addSubview(songsTableView)
        view.addSubview(activityIndicator)
    }
    private func setConstraints() {
        songsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        songsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        songsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        songsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 100).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
extension SongsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsPresenter?.songs?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SongTableViewCell.self), for: indexPath) as? SongTableViewCell
        guard
            let artist = songsPresenter?.songs?.results[indexPath.row].artistName,
            let track = songsPresenter?.songs?.results[indexPath.row].trackName,
            let trackImage = songsPresenter?.songs?.results[indexPath.row].artworkUrl100
        else { return UITableViewCell() }
        
        cell?.presenter = songsPresenter
        cell?.configure(track: track, artist: artist, trackImage: trackImage)
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
extension SongsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewModel = DetailSongViewModel(
            trackName: songsPresenter?.songs?.results[indexPath.row].trackName ?? "",
            artistName: songsPresenter?.songs?.results[indexPath.row].artistName ?? "",
            trackImage: songsPresenter?.songs?.results[indexPath.row].artworkUrl100 ?? "",
            trackUrl: songsPresenter?.songs?.results[indexPath.row].previewUrl  ?? "")
        
        songsPresenter?.showDetailView(detail: detailViewModel)
    }
}
extension SongsViewController: SongsViewProtocol {
    func succes() {
        DispatchQueue.main.async {
            self.songsTableView.reloadData()
        }
    }
    func failure(error: Error) {
        print(error)
    }
}
extension SongsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        activityIndicator.isHidden = true
        activityIndicator.startAnimating()
        guard let keyWord = searchBar.text else { return }
        guard keyWord.count >= 3 else { return }
        songsPresenter?.getSongs(keyWord: keyWord)
        songsTableView.isHidden = false
        activityIndicator.stopAnimating()
    }
}
