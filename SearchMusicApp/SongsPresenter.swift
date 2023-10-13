//
//  SongsPresenter.swift
//  WheatherApp
//
//  Created by Владимир on 12.10.2023.
//

import Foundation
import UIKit
protocol SongsViewProtocol: AnyObject {
    func succes()
    func failure(error: Error)
}
protocol SongsPresenterProtocol: AnyObject {
    var songs: FetchedSongs? { get set }
    init(router: SongsRouterProtocol, interactor: SongsInteractorProtocol)
    func getSongs(keyWord: String)
    func showDetailView(detail: DetailSongViewModel)
    func didLoadSong(songs: Result<FetchedSongs, Error>)
}
final class SongsPresenter {
    
    weak var view: SongsViewProtocol?
    var router: SongsRouterProtocol?
    var interactor: SongsInteractorProtocol?
    var songs: FetchedSongs?
    required init(router: SongsRouterProtocol, interactor: SongsInteractorProtocol) {
        self.interactor = interactor
        self.router = router
    }
}
extension SongsPresenter: SongsPresenterProtocol {
    func showDetailView(detail: DetailSongViewModel) {
        router?.openDetailView(detail: detail)
    }
    func didLoadSong(songs: Result<FetchedSongs, Error>) {
        switch songs {
        case .failure(let error):
            view?.failure(error: error)
        case .success(let songs):
            self.songs = songs
            view?.succes()
        }
    }
    func getSongs(keyWord: String) {
        interactor?.loadSongs(keyWord: keyWord)
    }
}
