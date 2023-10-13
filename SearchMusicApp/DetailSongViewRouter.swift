//
//  DetailSongViewRouter.swift
//  SearchMusicApp
//
//  Created by Владимир on 13.10.2023.
//

import Foundation

protocol DetailSongViewRouterProtocol: AnyObject {
    
}
class DetailSongViewRouter: DetailSongViewRouterProtocol {
    weak var presenter: DetailSongViewPresenterProtocol?
}
