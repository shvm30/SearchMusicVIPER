//
//  Builder.swift
//  WheatherApp
//
//  Created by Владимир on 12.10.2023.
//

import UIKit

class SongsViewModuleBuilder {
    static let shared = SongsViewModuleBuilder()
    private init() {}
    func createSongsViewContoller() -> UIViewController {
        let viewController = SongsViewController()
        let interactor = SongsInteractor()
        let router = SongsRouter()
        let presenter = SongsPresenter(router: router, interactor: interactor)
        viewController.songsPresenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController
        return viewController
    }
}
