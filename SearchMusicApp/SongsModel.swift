//
//  SongsModel.swift
//  WheatherApp
//
//  Created by Владимир on 12.10.2023.
//

import Foundation


// MARK: - FetchedSongs
struct FetchedSongs: Decodable {
    let results: [SongInfo]
}

// MARK: - SongInfo
struct SongInfo: Decodable {
    let artistName: String?
    let trackName: String?
    let artworkUrl100: String?
    let previewUrl: String?
}


