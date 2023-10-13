//
//  DetailSongViewModuleBuilder.swift
//  SearchMusicApp
//
//  Created by Владимир on 13.10.2023.
//

import UIKit

class DetailSongViewModuleBuilder {
    static let shared = DetailSongViewModuleBuilder()
    func buildModule(songDetail: DetailSongViewModel) -> UIViewController {
        let interactror = DetailSongViewInteractor(songDetail: songDetail)
        let vc = DetailSongViewViewController()
        let router = DetailSongViewRouter()
        let presenter = DetailSongViewPresenter(interactor: interactror, router: router)
        vc.presenter = presenter
        presenter.view = vc
        interactror.presenter = presenter
        router.presenter = presenter
        return vc
    }
}
