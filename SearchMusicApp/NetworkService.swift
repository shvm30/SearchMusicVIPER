//
//  NetworkService.swift
//  WheatherApp
//
//  Created by Владимир on 12.10.2023.
//

import Foundation
import UIKit
protocol NetworkServiceProtocol {
    func fetchData(keyWord: String?, comlition: @escaping(Result<FetchedSongs, Error>) -> Void)
}
protocol LoadImageServiceProtocol {
    func loadImage(stringUrl: String, complition: @escaping(Result<UIImage, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    private func getUrl(searchKeyWord: String?) -> URL? {
        guard let searchKeyWord = searchKeyWord else { return nil }
        let stringUrl = TextConstants.baseSearchUrl.rawValue + searchKeyWord
        let url = URL(string: stringUrl)
        return url
    }
    internal func fetchData(keyWord: String?, comlition: @escaping(Result<FetchedSongs, Error>) -> Void) {
        guard let url = getUrl(searchKeyWord: keyWord) else {
            comlition(.failure(NetworkServiceErrors.invalidUrl))
            return
        }
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil { comlition(.failure(NetworkServiceErrors.invalidRequest)) }
                guard let data = data else { comlition(.failure(NetworkServiceErrors.invalidData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let songs = try decoder.decode(FetchedSongs.self, from: data)
                    print(songs)
                    comlition(.success(songs))
                } catch {
                    comlition(.failure(NetworkServiceErrors.inavalidDecode))
                    print(error)

                }
            }.resume()
        }
    }
}
class LoadImageService: LoadImageServiceProtocol {
    func loadImage(stringUrl: String, complition: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: stringUrl) else {
            complition(.failure(NetworkServiceErrors.invalidUrl))
            return
        }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            guard let data = data else {
                complition(.failure(NetworkServiceErrors.invalidRequest))
                return
            }
            guard let image = UIImage(data: data) else {
                complition(.failure(NetworkServiceErrors.invalidData))
                return
            }
            complition(.success(image))
        }
    }
}

enum NetworkServiceErrors: Error {
    case invalidUrl, invalidData, inavalidDecode, invalidRequest
}
