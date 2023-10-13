//
//  DetailSongViewPresenter.swift
//  SearchMusicApp
//
//  Created by Владимир on 13.10.2023.
//

import UIKit

protocol DetailSongViewPresenterProtocol: AnyObject {
    var detailModel: DetailSongViewModel? { get set }
    var isPlayerPlaying: Bool { get set }
    func viewDidLoaded()
    func imageIsLoaded(image: Result<UIImage, Error>)
}

class DetailSongViewPresenter: DetailSongViewPresenterProtocol {
    weak var view: DetailSongViewViewControllerProtocol?
    var detailModel: DetailSongViewModel?
    var interactor: DetailSongViewInteractorProtocol
    var router: DetailSongViewRouterProtocol
    var isPlayerPlaying: Bool = false
    init(interactor: DetailSongViewInteractorProtocol, router: DetailSongViewRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    func viewDidLoaded() {
        self.detailModel = interactor.songDetail
        guard let detailModel = detailModel else { return }
        view?.showDetail(details: detailModel)
        getImage(stringUrl: detailModel.trackImage)
    }
    func getImage(stringUrl: String) {
        interactor.loadImage(stringUrl: stringUrl)
    }
    func imageIsLoaded(image: Result<UIImage, Error>) {
        switch image {
        case .failure(let error):
            print(error)
        case .success(let image):
            view?.succes(image: image)
        }
    }
}
