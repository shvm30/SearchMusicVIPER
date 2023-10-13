//
//  SongsRouter.swift
//  SearchMusicApp
//
//  Created by Владимир on 13.10.2023.
//

import UIKit

protocol SongsRouterProtocol: AnyObject {
    func openDetailView(detail: DetailSongViewModel)
}
class SongsRouter: SongsRouterProtocol {
    weak var view: UIViewController?
    
    func openDetailView(detail: DetailSongViewModel) {
        let detailViewController = DetailSongViewModuleBuilder.shared.buildModule(songDetail: detail)
        view?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
