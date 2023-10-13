//
//  SongsInteractor.swift
//  SearchMusicApp
//
//  Created by Владимир on 13.10.2023.
//

import Foundation

protocol SongsInteractorProtocol: AnyObject {
    func loadSongs(keyWord: String)
}
class SongsInteractor: SongsInteractorProtocol {
    weak var presenter: SongsPresenterProtocol?
    let networkService = NetworkService()
    func loadSongs(keyWord: String) {
        networkService.fetchData(keyWord: keyWord) { [weak self] result in
            self?.presenter?.didLoadSong(songs: result)
        }
    }
}

