//
//  DetailSongViewInteractor.swift
//  SearchMusicApp
//
//  Created by Владимир on 13.10.2023.
//

import Foundation
import AVKit
protocol DetailSongViewInteractorProtocol: AnyObject {
    var songDetail: DetailSongViewModel { get set }
    func loadImage(stringUrl: String)
}
class DetailSongViewInteractor: DetailSongViewInteractorProtocol {
    var songDetail: DetailSongViewModel
    weak var presenter: DetailSongViewPresenter?
    private let loadImageService = LoadImageService()
    private var audioPlayer: AVPlayer?
    init(songDetail: DetailSongViewModel) {
        self.songDetail = songDetail
    }
    func loadImage(stringUrl: String) {
        loadImageService.loadImage(stringUrl: stringUrl) { [weak self] result in
            self?.presenter?.imageIsLoaded(image: result)
        }
    }
}
